Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbTJ3VmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbTJ3VmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:42:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:18356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262921AbTJ3VmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:42:16 -0500
Date: Thu, 30 Oct 2003 13:44:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: age <ahuisman@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: READAHEAD
Message-Id: <20031030134407.0c97c86e.akpm@osdl.org>
In-Reply-To: <bnrdqi$uho$1@news.cistron.nl>
References: <bnrdqi$uho$1@news.cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

age <ahuisman@cistron.nl> wrote:
>
> I have a problem which i don`t understand and i hope that you
>  will and can  help me. The problem is that i experience strange disk
>  read performance. I have to set hdparm -m16 -u1 -c1 -d1 -a4096 /dev/hde
>  to get  timing buffered disk reads of 56 MB/SEC.
>  When i disable readahead i get 17 MB/SEC
>  When i enable readahead with -a8 i get  17 MB/SEC
>  When i enable readahead with -a16 i get 24,5 MB/SEC
>  When i enable readahead with -a32 i get 30,5 MB/SEC
>  When i enable readahead with -a64 i get 35 MB/SEC
>  When i enable readahead with -a128 i get 39 MB/SEC
>  When i enable readahead with -a256 i get 39 MB/SEC
>  When i enable readahead with -a512 i get 41 MB/SEC
>  When i enable readahead with -a1024 i get 50 MB/SEC
>  When i enable readahead with -a2048 i get 50 MB/SEC
>  When i enable readahead with -a4096 i get 56 MB/SEC
>  With -a8192,-a16384 and -a32768 i get also 56MB/SEC
> 
>  Before, i never had to set readahead so high
>  Please could you tell me, what is going on here ?

Lots of people have been reporting this.  It's rather weird.

Is the same effect observable when reading a large file, or is it only
observable via `hdparm -t'?

