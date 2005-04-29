Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVD2KFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVD2KFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVD2KFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:05:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59030 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262231AbVD2KF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:05:28 -0400
Date: Fri, 29 Apr 2005 11:05:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       dougg@torque.net, Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
Message-ID: <20050429100525.GA3342@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
	dougg@torque.net, Madhuresh_Nagshain@adaptec.com
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com> <20050425161411.GA11938@infradead.org> <426D2723.8070308@adaptec.com> <20050425181831.GA14190@infradead.org> <426E5BAF.4040003@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E5BAF.4040003@adaptec.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 11:18:07AM -0400, Luben Tuikov wrote:
> On 04/25/05 14:18, Christoph Hellwig wrote:
> > The point is that discovery must happen for each HBA separately because
> > we absolutely do not want to have global state.
> 
> OK.
> 
> Can you please define "global state"?

Sure, quoting your initial mail:

/----------------------------------------------------------------------
| 2. Sysfs SAS Domain
| -------------------
|
| Represent everything which "sits out there" in the SAS
| domain, irrespective of how you connect to it.
|
| /sys/bus/sas/
| /sys/bus/sas/<WWN_ta0>/
| /sys/bus/sas/<WWN_ta0>/phys/
|
| ...
\----------------------------------------------------------------------

Here you have a global hiearchy.  We are not interested in that, though -
we only care for what's visible from a certain HBA.

> In SAS, when the domain changes, the controller(s) connected to the
> domain get notification and pass it to the discovery process, which
> will run again.

Same as with fibre channel, and that's fine and expected.

> Overall, since the discovery process gets (internally) a "picture"
> of the domain out there, it would be appropriate to show this
> "picture" to the user.

Absolutely. 
