Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRLGK4C>; Fri, 7 Dec 2001 05:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282833AbRLGKzw>; Fri, 7 Dec 2001 05:55:52 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:7429 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S273261AbRLGKzg>; Fri, 7 Dec 2001 05:55:36 -0500
Message-ID: <3C109FE3.5070107@namesys.com>
Date: Fri, 07 Dec 2001 13:54:27 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: cs@zip.com.au
CC: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011207141913.A26225@zapff.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cameron Simpson wrote:

>On Thu, Dec 06, 2001 at 06:41:17AM +0300, Hans Reiser <reiser@namesys.com> wrote:
>| Have you ever seen an application that creates millions of files create 
>| them in random order?
>
>I can readily imagine one. An app which stashes things sent by random
>other things (usenet/email attachment trollers? security cameras taking
>thouands of still photos a day?). Mail services like hotmail. with a
>zillion mail spools, being made and deleted and accessed at random...
>

Ok, they exist, but they are the 20% not the 80% case, and for that 
reason preserving order in hashing is a legitimate optimization.

>
>
>|  Applications that create millions of files are usually willing to play 
>| nice for an order of magnitude performance gain also.....
>
>But they shouldn't have to! Specificly, to "play nice" you need to know
>about the filesystem attributes. You can obviously do simple things like
>a directory hierachy as for squid proxy caches etc, but it's an ad hoc
>thing. Tuning it does require specific knowledge, and the act itself
>presumes exactly the sort of inefficiency in the fs implementation that
>this htree stuff is aimed at rooting out.
>
>A filesystem _should_ be just a namespace from the app's point of view.
>Needing to play silly subdir games is, well, ugly.
>

Subdir games won't help you if the names are random ordered.

If names are truly random ordered, then the only optimization that can 
help is compression so as to cause the working set to still fit into RAM.

Compression will be sometime later than Reiser4, unless an unexpected 
sponsor comes along, but we will do it eventually.  

Hans

