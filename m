Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVAaLVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVAaLVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVAaLVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:21:17 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:41255 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261857AbVAaLVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:21:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=EBEgjyJv4PT47tuYMJiKZbHNFMtR5+GIyHgCmfMk5Y0MgJWgfNODz4wwMxxxWi6nrkf3am4ZDyDhdag6xQOiYUc3E8cst0odwmxwiWY2TrFHFbDmt+cpVYRUTN1p8wZ+MxyPny90VoCSkEHC0ao0Gb9FgRFoK589lGvmJXOcs7g=
Date: Mon, 31 Jan 2005 06:21:06 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Sean Neakums <sneakums@zork.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
Message-ID: <20050131112106.GA3494@samarkand.rivenstone.net>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, Sean Neakums <sneakums@zork.net>,
	linux-kernel@vger.kernel.org
References: <20050129163117.1626d404.akpm@osdl.org> <1107155510.5905.2.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107155510.5905.2.camel@gaston>
User-Agent: Mutt/1.4i
From: Joseph Fannin <jfannin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 06:11:50PM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2005-01-29 at 16:31 -0800, Andrew Morton wrote:
> It seems -mm2 definitely has some problems regarding loading of modules,
> it pretty much fails loading all of them for me with some
> kobject_register errors, I haven't really found out what was up, but
> then, I didn't have much time neither.
> 
> radeonfb built-in operations seem to be ok on my PowerBook3,5 (ATI M9
> based), I'll try on a PowerBook5,4 (same as yours) tomorrow hopefully.
> 
> Does the machine hang with the screen completely cleared ? Do you see
> the penguin logo ? Did you try just using pmac_defconfig ?

    I'm getting a blank screen with radeonfb on two boxes here as
well. One is a beige g3, the other is i386; both have PCI Radeon 7000s
with radeonfb non-modular. 

    On the PC I could see the earliest kernel messages in VGA text
mode before radeonfb took over and the screen went blank -- no
penguin, and the logo is enabled.  Booting with radeonfb:off seemed to
work except for the module problem in -rc2-mm2:

    On the ppc box I tried both -rc2-mm1 and -rc2-mm2.  Both hung and
then rebooted after 3 minutes, so it seems to be panicing somewhere.
I backed the massive-radeonfb patch out of -mm2 and radeonfb worked,
so I got as far as the module thing again.

    So yeah, it's possible that there's something in -mm1 that panics
my ppc, and radeonfb is just making a blank screen, but it seems more
likely that radeonfb is panicing.  I tried to get netconsole working
on both machines, but it didn't work out for unrelated reasons.

    Hopefully I'll have more time to poke at this tomorrow; maybe this
is helpful somehow.
-- 
Joseph Fannin
jfannin@gmail.com
