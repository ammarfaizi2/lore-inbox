Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTKUSrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 13:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTKUSrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 13:47:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16395 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S264414AbTKUSrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 13:47:03 -0500
Date: Fri, 21 Nov 2003 19:46:51 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Len Brown <len.brown@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [BKPATCH] ACPI for 2.4
Message-ID: <20031121184651.GA16548@alpha.home.local>
References: <1069189083.2970.540.camel@dhcppc4> <1069326962.16410.49.camel@dhcppc4> <20031121174909.GA16457@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121174909.GA16457@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

in fact this is not an ACPI problem. It's the ATYFB driver which never
worked before on this machine which prevents it from rebooting. That
doesn't surprize me, since this bios doesn't reinitialize anything properly
(previously, this bios hung on the IDE controller if APIC was set).

Once back to VESAFB, everything's OK, so there's no regression at all.

Sorry for the noise,
Willy

On Fri, Nov 21, 2003 at 06:49:09PM +0100, Willy Tarreau wrote:
> Hi Len,
> 
> On Thu, Nov 20, 2003 at 06:16:03AM -0500, Len Brown wrote:
> > Hi Marcelo, please do a 
> > 
> > 	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23
> > 
> 
> This version, as well as the original 2.4.23-rc2 code cannot reboot my
> VAIO. I don't know yet when the problem got in, since I've been using
> a 2.4.21 base + acpi-20030424-2.4.21-rc1.diff for a long time without
> this problem, and don't know if this was the case with intermediate
> versions since it's not something that I immediately notice.
> 
> I will try to identify which pre-release brought this problem.
> 
> Basically, when I reboot, the screen goes black, and I hear the
> speakers shut down exactly as when it will reboot. But nothing
> appears on the screen anymore. I must say that I also had this
> behaviour with the above version only when I used LOCAL_APIC.
> But I tried both with and without, without success. I clearly
> suspect my BIOS since it's a real crap, but since it once worked,
> I'll search a bit.
> 
> Other than that, power down works pretty well (this has always
> been a problem on this crap too), and the rest of the kernel is
> really fine and stable.
> 
> Regards,
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
