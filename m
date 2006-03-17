Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWCQNgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWCQNgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbWCQNgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:36:46 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:21119 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751023AbWCQNgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:36:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Vd7wsnuWmmkeXWtNBCF/CuW2Q7p5rsxV1Z3YcpzhvD8OusbunJJEZeYEb7B3ruKx3yKZHRO5lMC3m6htg3hmgDeh8BHECFut7CYFrqFLtsn2yaINQIJT70Cw9hDpT3i/A6LdnfqCwZrLk/GrC5diz+yX9ilYcpPFW4OlTxZlbTA=  ;
Message-ID: <441ABB68.1020502@yahoo.com.au>
Date: Sat, 18 Mar 2006 00:36:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/2] mspec driver
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>	<20060316163728.06f49c00.akpm@osdl.org> <yq0bqw5utyc.fsf_-_@jaguar.mkp.net>
In-Reply-To: <yq0bqw5utyc.fsf_-_@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:

> +static int
> +mspec_mmap(struct file *file, struct vm_area_struct *vma, int type)

...

> +	vma->vm_flags |= (VM_IO | VM_LOCKED | VM_RESERVED | VM_PFNMAP);

VM_PFNMAP actually has a fairly specific meaning [unlike the rest of
them :)] so you should be careful with it. Actually if you set vm_pgoff
in the right way, then that should enable you to do COWs on these areas
if that is what you want.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
