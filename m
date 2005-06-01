Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFAV0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFAV0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFAV0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:26:17 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:54436 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261152AbVFAVXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:23:08 -0400
Message-ID: <002501c566f7$7ed2b2e0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Bill Davidsen" <davidsen@tmr.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com> <20050601192934.GP20782@holomorphy.com> <429E10B9.601@tmr.com>
Subject: Re: Swap maximum size documented ?
Date: Wed, 1 Jun 2005 18:15:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Bill Davidsen" <davidsen@tmr.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, June 01, 2005 15:47
Subject: Re: Swap maximum size documented ?


> >
> >>Does this apply to mmap as well? I have an application which currently
> >>uses 9TB of data....

With this much data, you might consider investigating its compressability.
If it turned out to be highly compressable, algorithmic changes in how the
data is handled might considerably lighten the load on MM and disk
subsystems.  Its almost always cheaper to compress/decompress cached data in
memory than hit physical media.

