Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVH3US7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVH3US7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVH3US7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:18:59 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:44932 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbVH3US6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:18:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eqpJmzcc1DTSXc36HfMOSQwWOv0tGtA7c/+aUQWLZHFzC7zl2KMhAaQzzTQVgZAtLw1I1iokZDPhsHhJcXCyGSrdPK0sOHUG3FBUlns0M9LzGCI2Rj8ymdUAcMmhW7nkbIHQ+8p6fOrzI8kg0oF/tJ2jtWEGdJQU66DJvhb8Y4A=
Message-ID: <4807377b05083013185767744a@mail.gmail.com>
Date: Tue, 30 Aug 2005 13:18:57 -0700
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Cc: shemminger@osdl.org, Steve Kieu <haiquy@yahoo.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <43145FB5.6080300@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830122937.79855.qmail@web53605.mail.yahoo.com>
	 <43145FB5.6080300@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 2.6.11/12 when it isn't working maybe you should send us the output
of lspci -vvv

just a hint, I'm guessing its power management related, and / or
something to do with the pci bus code.

On 8/30/05, Daniel Drake <dsd@gentoo.org> wrote:
> Forwarding on, please reply-to-all in future.
> 
> Steve Kieu wrote:
> > Hi all,
> >
> > I have "fixed" the problem in a very wierd way.Reading
> > your post I thought maybe when removing the driver
> > itself it set some bit incorrectly. Then I decided to
> > do:
> >
> > Boot with init=/bin/bash  so bypass all other things.
> > modprobe skge
> >
> > run ifconfig eth0 ip_num  up
> >
> >
> > ping  a host
> >
> > then while pinging hit Ctrl+Alt+Del key to hot reboot
> > the system.
> >
> > I still see the light at the hub lits. Now I boot to
> > winXP and as I expected , it worked!
> >
> > No I boot 2.6.11 and it worked, so the problem resolve
> > but I am tooooo scared to run 2613 now :-)
> >
> > Hope this information helps debuging the driver.
> >
> > Thanks.
> >
> > S.KIEU
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
