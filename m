Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWHBCed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWHBCed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWHBCed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:34:33 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:24649 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751036AbWHBCec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:34:32 -0400
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: frequent slab corruption (since a long time)
X-Message-Flag: Warning: May contain useful information
References: <20060802021617.GH22589@redhat.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 01 Aug 2006 19:34:29 -0700
In-Reply-To: <20060802021617.GH22589@redhat.com> (Dave Jones's message of "Tue, 1 Aug 2006 22:16:17 -0400")
Message-ID: <adairlb3lxm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Aug 2006 02:34:31.0464 (UTC) FILETIME=[2F1F2280:01C6B5DC]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > There's a collection of corruption reports at
 > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=160878

I notice that the first few reports (kernels <= 2.6.14) have len=4096,
while the later reports (kernels >= 2.6.16) have len=2048.  So
assuming it's the same bug, the use after free has moved from a
4096-byte slab to a 2048-byte slab.  Were there ny data structures we
shrank between 2.6.14 and 2.6.16?
