Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTEVIDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbTEVIDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:03:05 -0400
Received: from fmr06.intel.com ([134.134.136.7]:32711 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262547AbTEVIDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:03:02 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: must-fix list, v5
Date: Thu, 22 May 2003 01:16:04 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2B5@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: must-fix list, v5
Thread-Index: AcMf6FtZ3vHTSVIjT/CE9Mf1SpkBXAAUEqgw
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Andrew Morton" <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 May 2003 08:16:04.0613 (UTC) FILETIME=[63818350:01C3203A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Andrew Morton [mailto:akpm@digeo.com] 

Hi just wanted to add some comments below:

>  drivers/acpi/
>  ~~~~~~~~~~~~~
>  
>  o davej: ACPI has a number of failures right now.  There are 
> a number of
> @@ -710,25 +766,32 @@
>    "network card doesn't recieve packets" booting with 
> 'acpi=off noapic' fixes
>    it.
>  
>    alan: VIA APIC stuff is one bit of this, there are also some other
>    reports that were caused by ACPI not setting level v edge 
> trigger some
>    times
>  
>  o davej: There's also another nasty 'doesnt boot' bug which 
> quite a few
>    people (myself included) are seeing on some boxes 
> (especially laptops).

Working on these (they're all in bugzilla), more help needed of course
:)

> +o mochel: it seems the acpi irq routing code could use a 
> serious rewrite.

No the problem is the ACPI irq routing code is trying to piggyback on
the existing MPS-specific data structures, and it's generally a hack. So
yes mochel is right, but it is also purging MPS-ities from common code
as well. I've done some preliminary work in this area and it doesn't
seem to break anything (yet) but a rewrite in this area imho should not
be rushed out the door. And, I think the above bugs can be fixed w/o the
rewrite.

> +o mochel: ACPI suspend doesn't work.  Important, not 
> cricital.  Pat is
> +  working it.

Go, Pat, go!

Regards -- Andy
