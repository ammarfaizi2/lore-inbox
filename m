Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWCWITn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWCWITn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWCWITn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:19:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1411 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030207AbWCWITm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:19:42 -0500
Subject: RE: [RFC PATCH 35/35] Add Xen virtual block device driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>,
       ian.pratt@cl.cam.ac.uk
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 09:19:31 +0100
Message-Id: <1143101972.3147.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 16:52 +0000, Ian Pratt wrote:
> > This is another thing that has always put me off.  The 
> > virtual block device driver has the ability to masquerade as 
> > other types of block devices.  It actually claims to be an 
> > IDE or SCSI device allocating the appropriate major/minor numbers.
> > 
> > This seems to be pretty evil and creating interesting failure 
> > conditions for users who load IDE or SCSI modules.  I've seen 
> > it trip up a number of people in the past.  I think we should 
> > only ever use the major number that was actually allocated to us.
> 
> We certainly should be pushing everyone toward using the 'xdX' etc
> devices that are allocated to us.

yes but you are faking something stupid ;)
You aren't ide, you don't take the IDE ioctls. So please just nuke this
bit..


