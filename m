Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWEIMwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWEIMwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWEIMwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:52:08 -0400
Received: from secure.htb.at ([195.69.104.11]:51979 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932294AbWEIMwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:52:06 -0400
Date: Tue, 9 May 2006 14:51:57 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to read BIOS information
Message-Id: <20060509145157.19edab87.delist@gmx.net>
In-Reply-To: <44608B0D.3050300@stesmi.com>
References: <445F5228.7060006@wipro.com>
	<1147099994.2888.32.camel@laptopd505.fenrus.org>
	<445F5DF1.3020606@wipro.com>
	<1147101329.2888.39.camel@laptopd505.fenrus.org>
	<445F63B3.2010501@wipro.com>
	<20060508152659.GG1875@harddisk-recovery.com>
	<4460273E.5040608@wipro.com>
	<1147172624.3172.60.camel@localhost.localdomain>
	<44608B0D.3050300@stesmi.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']kJW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FdRh0-0004FV-00*lbHNl0yf8Po*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Stefan Smietanowski <stesmi@stesmi.com> (Tue, 09 May 2006
14:29:01 +0200):
> Alan Cox wrote:
> > On Maw, 2006-05-09 at 10:53 +0530, Madhukar Mythri wrote:
> > 
> >>  yeah, your are correct. but, the thing is my superiors want, even
> >if  >kernel not reconize/use HT, we have to capture it from BIOS...
> >>Thats why i asked as, how to read BIOS information?
> > 
> > 
> > You ask the BIOS vendor for the exact board in question.
> > 
> > If you want to ask the processor itself then you can use the model
> > specific registers. These are accessible via /dev/cpu/<cpuid>/msr so
> > you can perform the Intel recommended sequence for checking if the
> > processor has HT enabled.
> > 
> > It might be simpler to look in /proc/cpuinfo if you just need the
> > basic information
> 
> He's actually asking if the BIOS has turned on HT, not if some other
> means has...
> 
> BUT, the only thing I can think of is turning OFF HT in the BIOS,
> reading the CMOS, storing it somewhere, turning ON HT, storing
> that somewhere and comparing them. Then he'll know that in his
> specific BIOS revision on his specific mainboard that bit is
> stored in one specific place and he can go from there.
> 
> Messy, definately not recommended, stupid but hey, if the bosses
> ask for it and you gotta give it ..
> 
> Just make triple sure you tell them that if you upgrade the BIOS
> the test might fail or if you change mainboard, etc.

IIRC the chipset should know about this?
Something like hex /sys/devices/pci0000:0/0000:00:00.0/config and
comparing registers with the chipset's datasheet?

> // Stefan

sl ritch
