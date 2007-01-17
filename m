Return-Path: <linux-kernel-owner+w=401wt.eu-S932221AbXAQKGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbXAQKGn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 05:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbXAQKGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 05:06:43 -0500
Received: from aurora.bayour.com ([212.214.70.50]:36013 "EHLO
	aurora.bayour.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbXAQKGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 05:06:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Weird harddisk behaviour
X-PGP-Fingerprint: B7 92 93 0E 06 94 D6 22  98 1F 0B 5B FE 33 A1 0B
X-PGP-Key-ID: 0x788CD1A9
X-URL: http://www.bayour.com/
References: <87bqkzp0et.fsf@pumba.bayour.com>
	<20070116141959.GC476@deepthought>
From: Turbo Fredriksson <turbo@bayour.com>
Organization: Bah!
Date: Wed, 17 Jan 2007 11:09:21 +0100
In-Reply-To: <20070116141959.GC476@deepthought> (Ken Moffat's message of
 "Tue, 16 Jan 2007 14:19:59 +0000")
Message-ID: <87y7o2hsmm.fsf@pumba.bayour.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ken Moffat <zarniwhoop@ntlworld.com>:

> On Tue, Jan 16, 2007 at 02:27:06PM +0100, Turbo Fredriksson wrote:
>> A couple of weeks ago my 400Gb SATA disk crashed. I just
>> got the replacement, but I can't seem to be able to create
>> a filesystem on it!
>> 
>> This is a PPC (Pegasos), running 2.6.15-27-powerpc (Ubuntu Dapper v2.6.15-27.50).
> Hi Turbo,
>
>  I think you have mac partitions (the first item is the partition
> map itself - very different from the dos partitions common on x86).
>
>  Certainly, fdisk from util-linux doesn't know about mac disks, and
> I thought the same was true for cfdisk and sfdisk.  Many years ago
> there was mac-fdisk, I think also known as pdisk, but nowadays the
> common tool for partitioning mac disks is probably parted.

Yes. See now that 'fdisk' is a softlink to 'mac-fdisk'...

> Please try parted.

Same thing ('mkpartfs primary ext2 0 400000'):

Jan 17 11:03:41 localhost kernel: [254985.117447] EXT2-fs: sdb1: couldn't mount RDWR because of unsupported optional features (10000).


The 'unsupported optional features' number keeps changing... ?
