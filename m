Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUK0QzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUK0QzL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUK0QzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:55:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:8125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261256AbUK0QzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:55:05 -0500
Message-ID: <41A8B0AF.8000906@osdl.org>
Date: Sat, 27 Nov 2004 08:51:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
References: <E1CY1rC-0007Y2-00@mta1.cl.cam.ac.uk>
In-Reply-To: <E1CY1rC-0007Y2-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt wrote:
>>>>@@ -42,7 +42,12 @@ extern void tapechar_init(void);
>>>>  */
>>>> static inline int uncached_access(struct file *file, unsigned long addr)
>>>
>>>Any chance you could just move uncached_access() to some asm/ header for
>>>all arches instead of making the ifdef mess even worse?
>>
>>I suppose a generic definition could go in asm-generic/iomap.h
>>with per-architecture definitions in asm/io.h.  However, I think
>>it would make sense to wait until PAT support gets added and then
>>think through exactly what needs doing rather than reorganising
>>things now.
> 
> 
> What do people think about this? Should I stick with the current
> patch that adds another #ifdef to uncached_access, or should I
> try pulling it out into asm-generic/iomap.h with per-arch
> definitions in asm/io.h ?
> 
> Is there anyone working on PAT support? It would be good to have
> their input.

Someone from NVidia has posted some PAT patches a few times.
(Terence Ripperda)  There's a thread beginning here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108180930118848&w=2

-- 
~Randy
