Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbRENVJC>; Mon, 14 May 2001 17:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262496AbRENVIw>; Mon, 14 May 2001 17:08:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52373 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262495AbRENVIq>;
	Mon, 14 May 2001 17:08:46 -0400
Date: Mon, 14 May 2001 17:08:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [Re: Inodes]
In-Reply-To: <200105142053.f4EKrhOh002240@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0105141700360.18112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Andreas Dilger wrote:

> Just to clarify, this means that the "inode numbers" reported by an
> msdos filesystem are a function of the disk-layout itself (i.e. they
> are determined at mount time), and not numbers created when the file
> is first accessed (AFAIK).

Wrong. open file. rename() it to another directory. truncate it to
zero. write to it. ->i_ino must have stayed they same. _Nothing_
on-disk that would be related to that file had stayed the same.
FAT simply doesn't allow inode numbers as functions of disk layout.

