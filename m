Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030512AbVKPVli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbVKPVli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVKPVli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:41:38 -0500
Received: from web34102.mail.mud.yahoo.com ([66.163.178.100]:25786 "HELO
	web34102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030512AbVKPVli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:41:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qpXKZouQvurCc6je/+dlwsNsEw2lA5GOG2br6x5gZ0a5oTJiB9qGMVG6GVKK7aB/9kXBy/zLSWo4LBTD0wOjX0+A5UfRTucPGXgZQP74qRvQEJCqkUtEoMgt9gST9g41AJHSf33UdAoDo15JpSZThM8NzvJxA0G3NXchnMcjEXs=  ;
Message-ID: <20051116214137.16970.qmail@web34102.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 13:41:37 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132175392.8811.49.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> Is this NFSv2?
> 
> Cheers,
>   Trond
> 
This is reproducible with O_DIRECT, but not without.

The profile looks the same:
samples  %        symbol name
647042   28.4114  zap_pte_range
572195   25.1249  unmap_mapping_range
324291   14.2395  _spin_lock
139259    6.1148  __bitmap_weight
137048    6.0177  zap_page_range
104614    4.5936  unmap_mapping_range_vma
63406     2.7841  debug_smp_processor_id
48906     2.1474  sub_preempt_count
46090     2.0238  unmap_vmas
27966     1.2280  add_preempt_count
23224     1.0198  invalidate_inode_pages2_range
21676     0.9518  unmap_page_range
17825     0.7827  _spin_unlock

I've had mixed results with a local ext3 file with the same test.  One run had a 37 second delay
while crossing 4GB, another happily went by without incident.

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
