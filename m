Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSJNNbu>; Mon, 14 Oct 2002 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbSJNNbu>; Mon, 14 Oct 2002 09:31:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28945 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261624AbSJNNbu>; Mon, 14 Oct 2002 09:31:50 -0400
Date: Mon, 14 Oct 2002 14:37:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bernd Petrovitsch <bernd@gams.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: open("/dev/ttyS1", O_LARGEFILE) blocks
Message-ID: <20021014143741.B2902@flint.arm.linux.org.uk>
References: <20021014125206.A2902@flint.arm.linux.org.uk> <2994.1034598563@frodo.gams.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2994.1034598563@frodo.gams.co.at>; from bernd@gams.at on Mon, Oct 14, 2002 at 02:29:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 02:29:23PM +0200, Bernd Petrovitsch wrote:
> Hmm, so I conclude that using something like "stty < /dev/ttyS0" is 
> evil in general and one should always use "stty -F /dev/ttyS0" instead.

Yep.  stty -F uses non-blocking mode, whereas the shell doesn't.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

