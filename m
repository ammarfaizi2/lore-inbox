Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWADCrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWADCrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 21:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWADCrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 21:47:10 -0500
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:47118 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S964969AbWADCrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 21:47:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch] es7000 broken without acpi
Date: Tue, 3 Jan 2006 20:46:22 -0600
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B09AF@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] es7000 broken without acpi
Thread-Index: AcYQ0dJ3ijUrCeMLTSWBRvUkevoQ8AABn9ng
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <snakebyte@gmx.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jan 2006 02:46:23.0365 (UTC) FILETIME=[0CB31B50:01C610D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com> wrote:
> >
> > > Eric Sesterhenn / snakebyte <snakebyte@gmx.de> wrote:
> >  > >
> >  > > hi,
> >  > >
> >  > > a make randconfig gave me a situation where es7000 was 
> enabled, 
> > but  > > acpi wasnt ( dont know if this makes sense ), gcc gave me 
> > some  > > compiling errors, which the following patch 
> fixes. Please  > 
> > cc me as i am not on the list. Thanks.
> >  > >
> >  > >
> >  >
> >  > I believe that es7000 requires ACPI, so a better fix 
> would be  > to 
> > enforce that within Kconfig.
> >  >
> >  > Natalie, can you please comment?
> > 
> > 
> >  You are correct, Andrew: ES7000 "preferred" mode is ACPI 
> (although it  
> > runs in MPS as well, which we use for debugging of 
> intermittent ACPI 
> > and  platform problems).
> >  I have done a similar patch (see
> >  http://bugzilla.kernel.org/attachment.cgi?id=5771&action=view) 
> > against  2.6.13, but the one suggested later by Peter Hagervall  
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0510.3/1302.html was  
> > actually taking care of the compile problem through Kconfig 
> better,  
> > since "acpi=off" option is available for our debug/testing 
> purposes  
> > anyway.
> 
> hm, OK.  I won't apply anything then - please send me your 
> preferred fix if you think there's something here which needs 
> fixing.  Either way, we should attempt to make the kernel 
> compile with all possible configs, if only to keep `make 
> randconfig' testers happy ;)

Sure, I will go though the code and make sure to cover all of them :)
--Natalie
