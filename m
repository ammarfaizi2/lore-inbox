Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTIOIke (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTIOIke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:40:34 -0400
Received: from angband.namesys.com ([212.16.7.85]:32658 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262009AbTIOIkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:40:33 -0400
Date: Mon, 15 Sep 2003 12:40:31 +0400
From: Oleg Drokin <green@namesys.com>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another ReiserFS (rpm database) issue (2.6.0-test5)
Message-ID: <20030915084031.GA510@namesys.com>
References: <Pine.LNX.4.53.0309141826030.9944@sjoerd.sjoerdnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309141826030.9944@sjoerd.sjoerdnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Sep 14, 2003 at 06:30:33PM +0200, Arjan Filius wrote:
> lseek(9, 36110336, SEEK_SET)            = 36110336
> read(9, "\4\0\354\377\3\0\n0\344\377\326\377\344\377\0\0\0\0\0\0"..., 65536) = 65536
> lseek(9, 7995392, SEEK_SET)             = 7995392
> read(9, "\2\0t@\0\0\366\377\0\0\341\377\357\377\0\0\0\0\0\0\0\0"..., 65536) = 65536
> lseek(9, 37879808, SEEK_SET)            = 37879808
> read(9, "\4\0\352\377\3\0=@\342\377\324\377\342\377\0\0\0\0\0\0"..., 65536) = 65536
> lseek(9, 34275328, SEEK_SET)            = 34275328
> read(9, "\0\0\372\377\0\0\366\377\0\0\337\377\355\377\0\0\0\0\0"..., 65536) = 65536
> <and here it "hangs" forever>

You mean, strace does not log more syscalls?

What if you mount your reiserfs partition with "-o nolargeio=1" mount option?

> -rw-r--r--    1 root     root        16384 Sep 14 18:16 conflictsindex.rpm
> -rw-r--r--    1 root     root     83431424 Sep 14 18:16 fileindex.rpm
> -rw-r--r--    1 root     root        57344 Sep 14 18:16 groupindex.rpm
> -rw-r--r--    1 root     root        94208 Sep 14 18:16 nameindex.rpm
> -rw-r--r--    1 root     root     54840904 Sep 14 18:16 packages.rpm
> -rw-r--r--    1 root     root       331776 Sep 14 18:16 providesindex.rpm
> -rw-r--r--    1 root     root     42246144 Sep 14 18:16 requiredby.rpm
> -rw-r--r--    1 root     root        16384 Sep 14 18:16 triggerindex.rpm

None of that fits into "bigger than 4G" cathegory.

Bye,
    Oleg
