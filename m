Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWDWBxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWDWBxi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 21:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWDWBxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 21:53:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:58018 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750711AbWDWBxi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 21:53:38 -0400
X-IronPort-AV: i="4.04,149,1144047600"; 
   d="scan'208"; a="27360611:sNHT16098999"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Sat, 22 Apr 2006 18:44:38 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D9D432E@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZmOwQ0vqKlFYFdSZWi/ukghPAIqAANQr4g
From: "Gross, Mark" <mark.gross@intel.com>
To: "Tim Small" <tim@buttersideup.com>
Cc: "Doug Thompson" <dthompson@lnxi.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Apr 2006 01:53:37.0310 (UTC) FILETIME=[BC9C33E0:01C66678]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Tim Small [mailto:tim@buttersideup.com]
>Sent: Saturday, April 22, 2006 11:32 AM
>To: Gross, Mark
>Cc: Doug Thompson; Ong, Soo Keong; Carbonari, Steven; Wang, Zhenyu Z;
>bluesmoke-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>Gross, Mark wrote:
>
>>You can never predict when a SMI will bubble through the system.  Even
>>if you handle case where the BIOS re-hides Dev0:Fun1 and not panic how
>>do you deal with the race between the BIOS SMI based handling and the
>>driver?  Who will end up reading (and clearing) the error registers
>>first?  There is no good way to share today.
>>
>>
>You could (at least from memory, on certain chipsets) modify the error
>reporting registers so that an SMI is no longer generated as a result
of
>MC ECC errors.  True, this doesn't fix many of the other problems
>related to this issue, but would be useful in a "modprobe xyz_edac
>force_unhide_MC_PCI=1" case.

You can get SMI's for more than just ECC events, suppressing the ECC
SMI's won't save you from the other SMI events that could happen.  

We need to work something out with the bios guys to do this right.
Today we don't have a good way of coordinating between the payload OS
and the BIOS for this type of platform level stuff.

>
>Closed-source BIOSes eh?  Who needs em ;-p.
No comment.

--mgross
