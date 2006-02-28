Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWB1ILN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWB1ILN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 03:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWB1ILN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 03:11:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13459 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750746AbWB1ILM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 03:11:12 -0500
Subject: Re: [Patch 5/7]  synchronous block I/O delays
From: Arjan van de Ven <arjan@infradead.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44037897.4050709@watson.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028448.5785.64.camel@elinux04.optonline.net>
	 <p73fym428cf.fsf@verdi.suse.de>  <44037897.4050709@watson.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 09:10:20 +0100
Message-Id: <1141114220.2935.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Our intent was to get an idea of user-initiated sync block I/O because
> there is some expectation from user space that a higher I/O priority will
> result in lower delays for such I/O. General throttling writes wouldn't 
> fit in
> this category though msync and O_SYNC would.
> 
> Are there a lot of other paths you see ? I'll root around more but if you
> could just list a few more, it'll help.

unmount
-o sync mounts
last-close kind of syncs on block devices (yes databases do this and
care)
fdatasync()/fsync()
open() (does a read seek, and may even do cluster locking stuff)
flock()



