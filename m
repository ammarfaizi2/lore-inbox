Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWFSQjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWFSQjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWFSQjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:39:48 -0400
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:40680 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964791AbWFSQjr (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:39:47 -0400
Message-ID: <4496D34F.4010007@namesys.com>
Date: Mon, 19 Jun 2006 09:39:43 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: nix@esperi.org.uk, akpm@osdl.org, vs@namesys.com, hch@infradead.org,
       Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, drepper@redhat.com
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>	<44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>	<1149766000.6336.29.camel@tribesman.namesys.com>	<20060608121006.GA8474@infradead.org>	<1150322912.6322.129.camel@tribesman.namesys.com>	<20060617100458.0be18073.akpm@osdl.org> <4494411B.4010706@namesys.com> <87ac8an21r.fsf@hades.wkstn.nix> <449668D1.1050200@namesys.com> <E1FsHzf-0004ES-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1FsHzf-0004ES-00@dorka.pomaz.szeredi.hu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:

>>Forgive myn utter ignorance of fuse, but does it currently context
>>switch to user space for every 4k written through VFS?
>>    
>>
>
>Yes, unfortunately it does, so fuse would benefit from batched writing
>as well, with some constraint on the number of locked pages to avoid
>DoS against the page cache.
>
>Miklos
>
>
>  
>
I would think that batched write is pretty essential then to FUSE
performance.  If we could then get the glibc authors to not sabotage the
using of a large block size to indicate that we like large IOs (see
thread on fseek implementation), reiser4 and FUSE would be all set for
improved performance.  Even without glibc developer cooperation, we will
get a lot of benefits.
