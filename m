Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284398AbRLENzt>; Wed, 5 Dec 2001 08:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284399AbRLENzk>; Wed, 5 Dec 2001 08:55:40 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9710 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S284398AbRLENzc>; Wed, 5 Dec 2001 08:55:32 -0500
From: Christoph Rohland <cr@sap.com>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, padraig@antefacto.com (Padraig Brady),
        scho1208@yahoo.com (Roy S.C. Ho), david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
In-Reply-To: <3C0D2843.5060708@antefacto.com>
	<E16BLxI-0003Ic-00@the-village.bc.nu>
	<snaqhzhj.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<m3wv02oz2w.fsf@linux.local>
	<itbmoy6m.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Organisation: SAP LinuxLab
Date: 05 Dec 2001 14:51:34 +0100
In-Reply-To: <itbmoy6m.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Message-ID: <m3k7w1pyft.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tachino,

On Wed, 05 Dec 2001, Tachino Nobuhiro wrote:
>> Please! If you do the limit checking for ramfs adapt the same
>> options like shmem.c
>> i.e. size,nr_inodes,nr_blocks,mode(+uid+gid). Don't invent yet
>> another mount option set. Also give them the same semantics. Best
>> would be to use shmem_parse_options.
> 
> These options are not my invention. Ramfs in 2.4.13-ac7 already has
> them.  But I agree the original options are not easy to understand,
> so if compatibility does not matter, I am glad to change them.

But this was never integrated into the stock kernel.

>> Further thought: Wouldn't it be better to add a no_swap mount
>> option to shmem and try to merge the two? There is a lot of code
>> duplication between mm/shmem.c and fs/ramfs/inode.c.
> 
> I thought that too. but I don't know it should be done in stable
> kernel series.

But we have 2.5 now. And that's where this should be done.

Greetings
		Christoph


