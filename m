Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292617AbSCOOaM>; Fri, 15 Mar 2002 09:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCOOaI>; Fri, 15 Mar 2002 09:30:08 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:27405 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292589AbSCOO3H>; Fri, 15 Mar 2002 09:29:07 -0500
Date: Fri, 15 Mar 2002 14:28:55 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
Message-ID: <20020315142854.E24984@flint.arm.linux.org.uk>
In-Reply-To: <20020315131612.C24984@flint.arm.linux.org.uk> <30439.1016201464@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <30439.1016201464@redhat.com>; from dwmw2@infradead.org on Fri, Mar 15, 2002 at 02:11:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 02:11:04PM +0000, David Woodhouse wrote:
> rmk@arm.linux.org.uk said:
> >  The following patch removes Alt-Sysrq-L and its associated hack to
> > kill of PID1, the init process.  This is a mis-feature.
> 
> This is not a mis-feature.
> 
> > If PID1 is killed, the kernel immediately enters an infinite loop in
> > the depths of do_exit() with interrupts disabled, completely locking
> > the machine.  Obviously you can only reach for the reset button or
> > power switch after this, leaving you with dirty filesystems.
> 
> This is a mis-feature. Leaving you without even the facility to use SysRq 
> any further is just insane.

Well, I've tried this approach, Linus rejected it.

If you'd like to take up this problem, be my guest.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

