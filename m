Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265706AbSJXWyN>; Thu, 24 Oct 2002 18:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbSJXWyN>; Thu, 24 Oct 2002 18:54:13 -0400
Received: from [63.204.6.12] ([63.204.6.12]:21915 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S265697AbSJXWyM>;
	Thu, 24 Oct 2002 18:54:12 -0400
Date: Thu, 24 Oct 2002 19:00:23 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Steven Dake <sdake@mvista.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
In-Reply-To: <Pine.LNX.4.33L2.0210241350230.20950-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0210241839490.10937-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Randy.Dunlap wrote:

> Preface question:  does cPCI support surprise removal (in the
> PICMG specs, not in some implementation)?  I know that PCI hotplug
> doesn't support surprise removal, only "coordinated" removal.

No, according to PICMG 2.1 R2.0, suprise removal is "non-compliant".

> So the question that has to be answered IMO is:  do we want to
> support surprise removal for something like manufacturing test,
> which doesn't abide by the coordinated removal protocol?
>
> or:  Do we have to support surprise removal, only because it can't
> be prevented?  I expect that this is the case, but I still don't
> see or understand the 20 ms time requirement.

I've not implemented it yet, but I'm pretty sure I can detect surprise
extractions in my cPCI driver.  The only thing holding me back at the
moment is that there's no clear way to report this status change via
pcihpfs without doing something a bit funky like reporting "-1" in the
"adapter" node.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

