Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262001AbSJIRsZ>; Wed, 9 Oct 2002 13:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbSJIRsZ>; Wed, 9 Oct 2002 13:48:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6675 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262001AbSJIRsY>; Wed, 9 Oct 2002 13:48:24 -0400
Date: Wed, 9 Oct 2002 18:54:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.41] trap in __release_resource
Message-ID: <20021009185405.B23671@flint.arm.linux.org.uk>
References: <200210091719.g99HJBVM001363@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210091719.g99HJBVM001363@kleikamp.austin.ibm.com>; from shaggy@austin.ibm.com on Wed, Oct 09, 2002 at 12:19:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 12:19:11PM -0500, David Kleikamp wrote:
> I was getting a NULL pointer dereference in __release_resource when I tried
> to boot 2.5.41.  I traced it down to your recent patch to 8250.c.  Since
> the call to serial8250_request_std_resource() is now conditional, the call
> to release_resource() needs to be conditional as well.  This patch fixes
> the problem.  It looks obviously correct to me, but I don't know this code
> at all.

Oddly, I've also sent this patch out in the last couple of days. 8)
Its correct.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

