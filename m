Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVEQPkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVEQPkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVEQPkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:40:49 -0400
Received: from fmr20.intel.com ([134.134.136.19]:47853 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261742AbVEQPjr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:39:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][PATCH] timers fixes/improvements
Date: Tue, 17 May 2005 08:38:45 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E054DA776@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH] timers fixes/improvements
Thread-Index: AcVYDDCpjI3D+miGQMGvGytmaYDs8gC6TeKg
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Greg KH" <greg@kroah.com>, "Christoph Lameter" <christoph@lameter.com>
Cc: "Oleg Nesterov" <oleg@tv-sign.ru>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, <shai@scalex86.org>
X-OriginalArrivalTime: 17 May 2005 15:38:46.0598 (UTC) FILETIME=[83954660:01C55AF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 13, 2005 3:36 PM, Greg KH wrote:
> > The definition of GET_INDEX is suspect:
> > 
> > #define GET_INDEX(a, b) (((a - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) +
b)
> > 
> > should this not be
> > 
> > #define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) +
\
> > 				((b) & 7))
> > 
> > ?
>
> Dely, any thoughts about this, or know who would know about it?

Greg,

I looked at the code and talked with Steve on this.  The fix is correct;
i.e. b has to be masked with 7.  Would Christoph or you send out a 
patch for the fix or would you like us to do so?  Thanks for finding out

the problem.

Thanks,
Dely
