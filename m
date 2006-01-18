Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWARJVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWARJVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWARJVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:21:30 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16017 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030320AbWARJV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:21:29 -0500
Subject: Re: io performance...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Max Waterman <davidmaxwaterman@fastmail.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43CDC44E.6080808@wolfmountaingroup.com>
References: <43CB4CC3.4030904@fastmail.co.uk>
	 <43CDAFE3.8050203@fastmail.co.uk>  <43CDC44E.6080808@wolfmountaingroup.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 09:21:04 +0000
Message-Id: <1137576064.25819.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-17 at 21:30 -0700, Jeff V. Merkey wrote:
> > How can I force it to be 'write back'?
> Forcing write back is a very bad idea unless you have a battery backed 
> up RAID controller.   

Not always. If you have a cache flush command and the OS knows about
using it, or if you don't care if the data gets lost over a power
failure (eg /tmp and swap) it makes sense to force it.

The raid controller drivers that fake scsi don't always fake enough of
scsi to report that they support cache flushes and the like. That
doesn't mean the controller itself is neccessarily doing one thing or
the other.

