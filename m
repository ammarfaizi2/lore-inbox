Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWAYWtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWAYWtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWAYWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:49:19 -0500
Received: from amdext4.amd.com ([163.181.251.6]:31968 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932196AbWAYWtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:49:18 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Wed, 25 Jan 2006 16:48:58 -0600
User-Agent: KMail/1.8
cc: "Robin Holt" <holt@sgi.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <200601241743.28889.raybry@mpdtxmail.amd.com>
 <07A9BE6C2CADACD27B259191@[10.1.1.4]>
In-Reply-To: <07A9BE6C2CADACD27B259191@[10.1.1.4]>
MIME-Version: 1.0
Message-ID: <200601251648.58670.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 25 Jan 2006 22:49:01.0152 (UTC)
 FILETIME=[88C45E00:01C62201]
X-WSS-ID: 6FC6DFD70BO645826-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Empirically, at least on Opteron, it looks like the first page of pte's is 
never shared, even if the alignment of the mapped region is correct (i. e. a 
2MB boundary for X86_64).    Is that what you expected?

(This is for a kernel built with just pte_sharing enabled, no higher levels.)

I would expect the first page of pte's not to be shared if the alignment is 
not correct, similarly for the last page if the mapped region doesn't 
entirely fill up the last page of pte's.

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

