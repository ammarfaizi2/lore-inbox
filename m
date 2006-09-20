Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751970AbWITRLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbWITRLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWITRLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:11:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53477 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751970AbWITRLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:11:15 -0400
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, npiggin@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 18:34:59 +0100
Message-Id: <1158773699.7705.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 09:25 -0700, ysgrifennodd Christoph Lameter:
> We already have such a functionality in the kernel its called a cpuset. A 
> container could be created simply by creating a fake node that then 
> allows constraining applications to this node. We already track the 
> types of pages per node. The statistics you want are already existing. 
> See /proc/zoneinfo and /sys/devices/system/node/node*/*.

CPUsets don't appear to scale to large numbers of containers (say 5000,
with 200-500 doing stuff at a time). They also don't appear to do any
tracking of kernel side resource objects, which is critical to
containment. Indeed for some of us the CPU management and user memory
management angle is mostly uninteresting.

I'm also not clear how you handle shared pages correctly under the fake
node system, can you perhaps explain that further how this works for say
a single apache/php/glibc shared page set across 5000 containers each a
web site.

Alan
