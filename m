Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWFSUjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWFSUjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWFSUjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:39:20 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:1975 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751151AbWFSUjT (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:39:19 -0400
Message-ID: <44970B77.6030906@namesys.com>
Date: Mon, 19 Jun 2006 13:39:19 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Akshat Aranya <aaranya@gmail.com>, vs <vs@thebsh.namesys.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, nix@esperi.org.uk, akpm@osdl.org,
       vs@namesys.com, hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com>	 <20060608121006.GA8474@infradead.org>	 <1150322912.6322.129.camel@tribesman.namesys.com>	 <20060617100458.0be18073.akpm@osdl.org> <4494411B.4010706@namesys.com>	 <87ac8an21r.fsf@hades.wkstn.nix> <449668D1.1050200@namesys.com>	 <E1FsHzf-0004ES-00@dorka.pomaz.szeredi.hu>	 <4496D34F.4010007@namesys.com>	 <E1FsNeQ-0004pV-00@dorka.pomaz.szeredi.hu> <e48344780606191052u43db7e45wd175e7f818c4a192@mail.gmail.com>
In-Reply-To: <e48344780606191052u43db7e45wd175e7f818c4a192@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akshat Aranya wrote:

> On 6/19/06, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> > I would think that batched write is pretty essential then to FUSE
>> > performance.
>>
>> Well, yes essential if the this is the bottleneck in write throughput,
>> which is most often not the case, but sometimes it is.
>>
>
> I can vouch for this.  I did some experiments with an example FUSE
> filesystem that discards the data in userspace.  Exporting such a
> filesystem over NFS gives us 80 MB/s writes when FUSE is modified to
> write with 32K block sizes.  With the standard FUSE (4K writes), we
> get  closer to 50 MB/s.

The ratios of 4k performance / large write performance are amusingly
similar for reiser4 and FUSE even though the filesystems and absolute
performance are totally different.  The principle is the same it seems
for both filesystems.

Vladimir, the benchmarks, please send them.....

Hans
