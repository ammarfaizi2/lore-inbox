Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUELDVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUELDVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUELDVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:21:36 -0400
Received: from fmr02.intel.com ([192.55.52.25]:33473 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264961AbUELDVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:21:02 -0400
Subject: Re: new laptop woes
From: Len Brown <len.brown@intel.com>
To: jnf <jnf@datakill.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSO.4.58.0405112032430.31433@metawire.org>
References: <A6974D8E5F98D511BB910002A50A6647615FB0B1@hdsmsx403.hd.intel.com>
	 <1084295342.12359.116.camel@dhcppc4>
	 <Pine.BSO.4.58.0405112032430.31433@metawire.org>
Content-Type: text/plain
Organization: 
Message-Id: <1084332057.12354.127.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 May 2004 23:20:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 21:37, jnf wrote:

> > try booting with "nolapic"
> 
> This worked - now seeing as it worked, and I can't find any mention of it 
> in the bootparam man page [and i havent dug through the source yet], what 
> exactly did i do?

Linux enables the Local APIC even on uni-processors systems so that it
can use the LOCal APIC timer.  This policy causes a significant
population of laptops to freeze when booted with ACPI enabled. 
Curiously, we've seen this failure go away on some laptops after a BIOS
upgrade -- so you shoul verify that you're running the latest BIOS for
your system.

Perhaps you could try the test patch here
http://bugzilla.kernel.org/show_bug.cgi?id=2044
and add a comment to the bug report on if it makes any difference or not.

> 
> > I escaped from CVS in 1994, underwent several years of therapy, and
> > haven't used it since.  I don't know what ACPI CVS is on SF, point me to
> > it and I'll be happy to delete it.
> 
> hehe no problem, I was under the impression that was the 'official' site 
> for acpi, but i found that odd seeing as nothing on the site seemed newer 
> than ~12 months, and i knew that ACPI had undergone some fixes/changes 
> since then.

/usr/src/MAINTAINERS lists me as the maintainer, and has this home page
for the project, which is updated periodically (tho not by me):
http://acpi.sourceforge.net/

cheers,
-Len


