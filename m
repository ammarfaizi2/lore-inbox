Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVHJWIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVHJWIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVHJWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:08:48 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:18325 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S932378AbVHJWIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:08:47 -0400
Date: Wed, 10 Aug 2005 15:07:44 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Hellwig <hch@infradead.org>, Zach Brown <zab@zabbo.net>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <20050810220744.GJ21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050803063644.GD9812@redhat.com> <courier.42F768D5.000046F2@courier.cs.helsinki.fi> <42F7A557.3000200@zabbo.net> <1123598983.10790.1.camel@haji.ri.fi> <20050810072121.GA2825@infradead.org> <courier.42F9AD38.000018F9@courier.cs.helsinki.fi> <20050810162618.GH21228@ca-server1.us.oracle.com> <courier.42FA3207.00002648@courier.cs.helsinki.fi> <20050810182155.GI21228@ca-server1.us.oracle.com> <courier.42FA6128.000009AE@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42FA6128.000009AE@courier.cs.helsinki.fi>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 11:18:48PM +0300, Pekka J Enberg wrote:
> Aah, I see GFS2 does that too so no deadlocks here. Thanks.
Yep, no problem :)

> You, however, don't maintain the same level of data consistency when reads
> and writes are from other filesystems as they use ->nopage.
I'm not sure what you mean here...

> Fixing this requires a generic vma walk in every write() and read(), no?
> That doesn't seem such an hot idea which brings us back to using ->nopage
> for taking the locks (but now the deadlocks are back). 
Yeah if you look through mmap.c in ocfs2_fill_ctxt_from_buf() we do this...
Or am I misunderstanding what you mean?
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
