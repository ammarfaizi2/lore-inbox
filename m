Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315618AbSENLik>; Tue, 14 May 2002 07:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSENLij>; Tue, 14 May 2002 07:38:39 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:25870 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315618AbSENLih>; Tue, 14 May 2002 07:38:37 -0400
Date: Tue, 14 May 2002 12:38:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020514123830.A18118@flint.arm.linux.org.uk>
In-Reply-To: <3CE0DDBE.F9EC80AC@ukaea.org.uk> <3CE0D067.6010302@evision-ventures.com> <3CE0E306.6171045B@ukaea.org.uk> <3CE0D952.7080403@evision-ventures.com> <3CE0F08A.5C41CAFA@ukaea.org.uk> <3CE0E538.5040502@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 12:21:44PM +0200, Martin Dalecki wrote:
> Well in the next patch round the hwgroup will be replaced with
> a spin lock, which is supposed to be shared between channels which need
> forced access serialization between them. Please look
> at patches 62a and 63 :-).

Something here smells fishy here - you shouldn't hold a spinlock for a long
time (a long time === spinlocking, setting up the drive, possibly scheduling,
transferring data, getting status, then unlocking).  Also, remember,
spinlocks are no-ops on uniprocessor systems.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

