Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVFCBLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVFCBLC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 21:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFCBLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 21:11:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26867 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261472AbVFCBK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 21:10:56 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "'Bill Huey \(hui\)'" <bhuey@lnxw.com>,
       "'john cooper'" <john.cooper@timesys.com>
Cc: "'Perez-Gonzalez, Inaky'" <inaky.perez-gonzalez@intel.com>,
       <dwalker@mvista.com>, "'Esben Nielsen'" <simlo@phys.au.dk>,
       "'Ingo Molnar'" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <rostedt@goodmis.org>
Subject: RE: [PATCH] Abstracted Priority Inheritance for RT
Date: Thu, 2 Jun 2005 18:10:18 -0700
Message-ID: <002501c567d9$04e9ea10$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20050603005422.GA6904@nietzsche.lynx.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Thu, Jun 02, 2005 at 01:43:54AM -0400, john cooper wrote:
> > That might have been me.  The last time I looked at this 
> specifically, 
> > full transitive promotion was being done in the RT patch.  However 
> > unlike your attempt at scaling the lock scope, the RT patch had one 
> > lock which coordinated all mutex dependency traversals 
> system wide.  
> > This lock must be speculatively acquired even before we ascertain
> > transitive promotion is required.
> > 
> > So it doesn't scale as well as it could in the case of
> > large count SMP systems.  The response was that of "get
> > it to work first and then we'll get it to scale" which
> > is reasonable.
> 
> Just curious, what do you thinks about the rw-lock comments 
> from Esben in that a real rw-lock can't be deterministic ?
>

I think it can be deterministic if the number of readers is limited (to 1)

