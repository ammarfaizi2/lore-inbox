Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWCQOMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWCQOMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030179AbWCQOMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:12:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22763 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932740AbWCQOMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:12:19 -0500
Message-ID: <441AC3A4.801@sgi.com>
Date: Fri, 17 Mar 2006 15:11:48 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/2] mspec driver
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>	<20060316163728.06f49c00.akpm@osdl.org>	<yq0bqw5utyc.fsf_-_@jaguar.mkp.net> <441ABB68.1020502@yahoo.com.au> <yq07j6tuq05.fsf@jaguar.mkp.net> <441AC300.8020003@yahoo.com.au>
In-Reply-To: <441AC300.8020003@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Jes Sorensen wrote:
>> We don't want COW here as the access is backed by special behavior in
>> the memory controller. We only allow shared mappings for that reason.
>>
> No problem, I think you should just stop using the VM_PFNMAP flag then.
> [Linus should jump in here if I'm wrong ;)]

I'd have to go back and find the discussion to verify, but if I
remember correctly the conclusion was that I needed to use it in
order to make sure that vm_normal_page() didn't start thinking it was
in fact a real page, ie. VM_PFNMAP + never a COW mapping..

Chers,
Jes


