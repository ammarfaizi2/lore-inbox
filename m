Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWFJPm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWFJPm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 11:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFJPm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 11:42:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47822 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751170AbWFJPm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 11:42:27 -0400
Date: Sat, 10 Jun 2006 16:42:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
Message-ID: <20060610154213.GA19077@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	"Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
	linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20060610143100.GA15536@sergelap.austin.ibm.com> <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448AE12E.5060002@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 05:11:42PM +0200, Stefan Richter wrote:
> Serge, could you reduce your patch to the nodemgr part and resubmit?

I'd prefer ieee1394 would just stop creating these thread entirely.
Sure, rescaning the bus might take some time, but so do pci or especially
scsi bus rescans.  A user should expect his thread to block when he
writes to an attribute caled rescan.

