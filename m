Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269594AbRHMAhQ>; Sun, 12 Aug 2001 20:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269595AbRHMAhG>; Sun, 12 Aug 2001 20:37:06 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:11790 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269594AbRHMAgx>; Sun, 12 Aug 2001 20:36:53 -0400
Date: Sun, 12 Aug 2001 17:36:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-pre1 unresolved symbols in fat.o/smbfs.o
In-Reply-To: <E15W5eq-0006Y5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108121735510.1228-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Aug 2001, Alan Cox wrote:
>
> Oops my fault. My kernel/ksyms goes
>
> EXPORT_SYMBOL(vfs_unlink);
> EXPORT_SYMBOL(vfs_rename);
> EXPORT_SYMBOL(vfs_statfs);
> EXPORT_SYMBOL(generic_file_llseek);
> EXPORT_SYMBOL(generic_read_dir);
> EXPORT_SYMBOL(__pollwait);
> EXPORT_SYMBOL(poll_freewait);
>
> If you edit yours and drop that line in then rebuild from clean all should
> be well

Hmm.. You should probably also add "no_llseek" there..

		Linus

