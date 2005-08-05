Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVHEH1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVHEH1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVHEH1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:27:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262891AbVHEH1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:27:18 -0400
Message-ID: <42F314CC.4000309@redhat.com>
Date: Fri, 05 Aug 2005 02:27:08 -0500
From: Mike Christie <mchristi@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux clustering <linux-cluster@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: [PATCH 00/14] GFS
References: <20050802071828.GA11217@redhat.com>	<1122968724.3247.22.camel@laptopd505.fenrus.org> <20050805071415.GC14880@redhat.com>
In-Reply-To: <20050805071415.GC14880@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland wrote:
> On Tue, Aug 02, 2005 at 09:45:24AM +0200, Arjan van de Ven wrote:
> 
>>* Why are you using bufferheads extensively in a new filesystem?
> 
> 
> bh's are used for metadata, the log, and journaled data which need to be
> written at the block granularity, not page.
> 

In a scsi tree
http://kernel.org/git/?p=linux/kernel/git/jejb/scsi-block-2.6.git;a=summary
there is a function, bio_map_kern(), in fs.c that maps a buffer into a
bio. It does not have to be page granularity. Can something like that be
used in these places?
