Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWFSJFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWFSJFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFSJFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:05:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:38111 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751249AbWFSJFY (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:05:24 -0400
Message-ID: <449668D1.1050200@namesys.com>
Date: Mon, 19 Jun 2006 02:05:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: Andrew Morton <akpm@osdl.org>, "Vladimir V. Saveliev" <vs@namesys.com>,
       hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>	<44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>	<1149766000.6336.29.camel@tribesman.namesys.com>	<20060608121006.GA8474@infradead.org>	<1150322912.6322.129.camel@tribesman.namesys.com>	<20060617100458.0be18073.akpm@osdl.org> <4494411B.4010706@namesys.com> <87ac8an21r.fsf@hades.wkstn.nix>
In-Reply-To: <87ac8an21r.fsf@hades.wkstn.nix>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:

>On 17 Jun 2006, Hans Reiser prattled cheerily:
>  
>
>>If the FS is called per page, then it turns out that 3) costs more than
>>1) and 2) for sophisticated filesystems.  As we develop fancier and
>>fancier plugins this will just get more and more true.  It decreases CPU
>>usage by 2x to use per sys_write calls into reiser4 rather than per page
>>calls into reiser4.
>>    
>>
>
>This seems to me to be something that FUSE filesystems might well like,
>too: I know one I'm working on would like to know the real size of the
>original write request (so that it can optimize layout appropriately
>for things frequently written in large chunks; the assumption being that
>if it's written in large chunks it's likely to be read in large chunks
>too).
>
>  
>
Hi Nix,

Forgive myn utter ignorance of fuse, but does it currently context
switch to user space for every 4k written through VFS?
