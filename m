Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315855AbSEMGqR>; Mon, 13 May 2002 02:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSEMGqQ>; Mon, 13 May 2002 02:46:16 -0400
Received: from angband.namesys.com ([212.16.7.85]:45459 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S315855AbSEMGqQ>; Mon, 13 May 2002 02:46:16 -0400
Date: Mon, 13 May 2002 10:46:15 +0400
From: Oleg Drokin <green@namesys.com>
To: "John O'Donnell" <johnnyo@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
Message-ID: <20020513104615.A10664@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com> <3CDF1F1B.1090302@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, May 12, 2002 at 10:04:11PM -0400, John O'Donnell wrote:

> I'm sorry.  This IS 2.4.18 - I havent played with 2.5 yet - but thanks 
> for the warning.
> This is a Seagate ST39102LW hooked into an Adaptec 29160.

Ok, if you want your fs back, correct way is to download latest preversion of
reiserfsprogs (reiserfsprogs-3.x.1c-pre4 for now) from namesys.com ftp site,
build it somewhere, boot off rescue media of some kind, and then run
reiserfsck with --rebuild-tree argument (and a path to your partition of
course). If you cannot build any binaries anywhere, I can send you a binary
of reiserfsck.
You problem is that pointer to data block got corrupted and now points
outside of the partition.
(notw, if you have some reiserfsck version on your rescue media, it won't
help you, because this exact problem got fixed only recently)

Bye,
    Oleg
