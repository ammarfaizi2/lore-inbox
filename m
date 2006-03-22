Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWCVFPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWCVFPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWCVFPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:15:50 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:22107 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750767AbWCVFPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:15:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aWieTUf1u8HELLwUd1Eq/0wNutCIPCvbEQpjaG34lSKVRPzrnHf2YZq/qxnGbv/GCLv2dLKS7MBUOu3hRIol+4ibFVdLNTebQdgOr6v+p+pK/vmaVNRuIuoEsaWLxBhJZfJJBy0URlmrWeJdXeXMy6kMzsQW0u4cVw6F7T90S0s=  ;
Message-ID: <4420DD59.6070407@yahoo.com.au>
Date: Wed, 22 Mar 2006 16:15:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __read_mostly on some hot fs variables
References: <20060315054416.GF3205@localhost.localdomain>	<1142403500.26706.2.camel@sli10-desk.sh.intel.com> <20060314233138.009414b4.akpm@osdl.org> <4417E047.70907@cosmosbay.com> <441EFE05.8040506@cosmosbay.com> <4420DB55.60803@cosmosbay.com>
In-Reply-To: <4420DB55.60803@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

>
> Before someone asks, it is valid to declare a pointer as 'read 
> mostly', even if the data pointed by the pointer is heavily modified. 
> hash table pointers and kmem_cache pointers are setup at boot time, so 
> they are perfect candidates  to 'read_mostly' section. Same apply for 
> 'struct vfsmount *'
>

Yes... why wouldn't it be if the variable is only written to once? This
is _exactly_ what __read_mostly section is for, isn't it?

Patch looks good though.

Nick
---
Send instant messages to your online friends http://au.messenger.yahoo.com 
