Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266540AbUBESmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266542AbUBESmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:42:14 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:9450 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S266540AbUBESl6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:41:58 -0500
Date: Thu, 5 Feb 2004 19:41:42 +0100 (MET)
From: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>
Reply-To: a.verweij@student.tudelft.nl
To: =?ISO-8859-15?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
cc: a.verweij@student.tudelft.nl, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>, <akpm@digeo.com>
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
In-Reply-To: <40228038.1070003@wanadoo.es>
Message-ID: <Pine.GHP.4.44.0402051936510.11035-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is interesting, I will test it myself later on. At one point Len
admitted to owning "foreign hardware :p" so maybe this could get resolved.

Personally I haven't tried kernels with newer forcedeth drivers, because I
can no longer explicitely set the power state of the NIC to D3. The
machine complains about irqs (new debugging code since forcedeth v.20 or
so) and will not powerdown.

On another note, have you noticed lockups of your system with heavy io?
Think of fsck'ing, burning cdroms, du on large dirs etc? Maybe it is
helpful to set up a list of boards and document what works or doesn't work
with which kernel. For instance the lockups with heavy io seem to be
resolved here if I leave APIC from my kernel.

Arjen

On Thu, 5 Feb 2004, [ISO-8859-15] Luis Miguel García wrote:

> Hi:
>
> Since Andrew Morton picked up latest acpi bk updates, nforce motherboards have problems, mainly with ethernet adapters. Reporters say that with acpi=off, the problm gets fixed, so we think the problem could be acpi. Some more useful info:
>
>
>
> On Tue, 3 Feb 2004, [ISO-8859-1] Luis Miguel García wrote:
>
>
> >> When I try to boot with latest mm series (such as actual rc3-mm1 or
> >> rc2-mm2), my nforce ethernet device doesn't works. It worked in the past
> >> with the forcedeth reverse engineered driver but now it keeps for 30 or
> >> more seconds halted (at boot) and then the network device dosn't run.
> >>
> >> Here is the dmesg of rc3-mm1. Do you want for me to test something? Thanks!
> >>
> >> P.S.:   The ACPI related messages are larger that in rc3.
> >
> >
>
> My e100 on an nforce2 won't work in rc3-mm1.
> The "acpi=off" boot parameter makes it go.
>
>
> And for the record, I can boot with that kernel and save one dmesg for you if you want. Only send me a request and I'll send it to you.
>
> P.S.: Sent any messages you want directly to me as i'm not subscribed to acpi-devel.
>
> Thanks,
>
> Luis Miguel García
>
>
>
>
>
> >Which part of nforce support are you talking about luis?
>
> >On Thu, 5 Feb 2004, Andrew Morton wrote:
>
>
> >> Luis Miguel Garc?a <ktech@wanadoo.es> wrote:
> >
> >
> >>> >
> >>> > Andrew Morton wrote:
> >>> >
> >>
> >>
> >>>> > >
> >>>
> >>>
> >>>>> > >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/
> >>>>> > >>
> >>>>> > >>
> >>>>> > >>
> >>>>> > >> - Merged some page reclaim fixes from Nick and Nikita.  These yield some
> >>>>> > >>  performance improvements in low memory and heavy paging situations.
> >>>>> > >>
> >>>>> > >>
> >>>>
> >>>>
> >>> >
> >>> > Andrew, do you know if this acpi pull down has nforce support fixed?
> >>
> >>
> >>
> >> It doesn't appear that way.
> >>
> >
> >
> >>> > Or perhaps it's even unnotified to the acpi team?
> >>
> >>
> >>
> >> I do not know.  Sending them a bugzilla ID would help, if such a thing exists.
> >>
> >>
> >>
> >> -------------------------------------------------------
> >> The SF.Net email is sponsored by EclipseCon 2004
> >> Premiere Conference on Open Tools Development and Integration
> >> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> >> http://www.eclipsecon.org/osdn
> >> _______________________________________________
> >> Acpi-devel mailing list
> >> Acpi-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >>
> >>
> >
> >
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>

