Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285972AbRLYXhN>; Tue, 25 Dec 2001 18:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285986AbRLYXhD>; Tue, 25 Dec 2001 18:37:03 -0500
Received: from white.pocketinet.com ([12.17.167.5]:37838 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S285972AbRLYXgn>; Tue, 25 Dec 2001 18:36:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Ryan Cumming <bodnar42@phalynx.dhs.org>,
        "James Stevenson" <mistral@stev.org>, <linux-kernel@vger.kernel.org>,
        <netfilter-devel@lists.samba.org>
Subject: Re: file names ?
Date: Tue, 25 Dec 2001 15:36:46 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <000701c18d82$57158ea0$0801a8c0@Stev.org> <E16IyNw-0003UO-00@phalynx>
In-Reply-To: <E16IyNw-0003UO-00@phalynx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEGlOVj8P8F7xztz000005f3@white.pocketinet.com>
X-OriginalArrivalTime: 25 Dec 2001 23:35:06.0081 (UTC) FILETIME=[C8780D10:01C18D9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 December 2001 12:41 pm, Ryan Cumming wrote:
> On December 25, 2001 12:25, James Stevenson wrote:
> > a small example is a smallish ext2 / filesystem
> > and the rest being a fat filesystem to that
> > it can be accessed from both windows and linux.
> > and there is not enough space on the ext2 to compile a kernel
> > anymore.
>
> Case-insensitivity is not your only problem. 'ln -s' is used multiple
> times during the kernel build process, I'd like to see a FAT
> filesystem try to handle that. I haven't checked, but the compile
> might also depend on the executable bit actually working, and being
> able to rename and unlink files in use. Even with filenames that do
> not collide in a case-insensitive namespace, the build will fail.
>
> The kernel compile requires a POSIX filesystem, which is a completely
> sane demand. I'd go as far as saying that all 'real' filesystems are
> POSIX compliant, and that non-POSIX filesystems should only be used
> for simple data file storage.
>

Actually there should be *no* problem at all. Just enable UMSDOS and 
the UMSDOS filesystem will take care of ensuring that the FAT 
filesystem supports the links, and the same filenames. Just don't try 
to extract the files anywhere but in Linux with UMSDOS enabled.

Err, and don't run scandisk or anything similar on the drives while in 
DOS/Windows....
