Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbWCQOJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWCQOJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbWCQOJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:09:20 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:7008 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932708AbWCQOJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:09:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cugJuhhzVRpMB4Da8g9hJkpq9MZZzJL8/RDqyzcYCj72PJxCnAVK38E2dZ9wiXntCITtdT7cctmj9RI4hTrurYN/SjVAx+4ZcQpU98PyZC5lTPNCkHgOnIn+mS3HDTq8DD3NpfQhIu5+ySTPpYi9KFkV1mRdnLhaKsHZNNuxaUo=  ;
Message-ID: <441AC300.8020003@yahoo.com.au>
Date: Sat, 18 Mar 2006 01:09:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/2] mspec driver
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>	<20060316163728.06f49c00.akpm@osdl.org>	<yq0bqw5utyc.fsf_-_@jaguar.mkp.net> <441ABB68.1020502@yahoo.com.au> <yq07j6tuq05.fsf@jaguar.mkp.net>
In-Reply-To: <yq07j6tuq05.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
>>>>>>"Nick" == Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> 
> Nick> Jes Sorensen wrote:
> 
>>>+ vma->vm_flags |= (VM_IO | VM_LOCKED | VM_RESERVED | VM_PFNMAP);
> 
> 
> Nick> VM_PFNMAP actually has a fairly specific meaning [unlike the
> Nick> rest of them :)] so you should be careful with it. Actually if
> Nick> you set vm_pgoff in the right way, then that should enable you
> Nick> to do COWs on these areas if that is what you want.
> 
> Yup, I went through that when I started using it. I think you guided
> me through it :-)
> 
> We don't want COW here as the access is backed by special behavior in
> the memory controller. We only allow shared mappings for that reason.
>

No problem, I think you should just stop using the VM_PFNMAP flag then.
[Linus should jump in here if I'm wrong ;)]

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
