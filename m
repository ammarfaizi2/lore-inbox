Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316861AbSE3WGi>; Thu, 30 May 2002 18:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSE3WGi>; Thu, 30 May 2002 18:06:38 -0400
Received: from fungus.teststation.com ([212.32.186.211]:14091 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316861AbSE3WGh>; Thu, 30 May 2002 18:06:37 -0400
Date: Fri, 31 May 2002 00:06:12 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Felipe Alfaro Solana <felipe_alfaro@msn.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Kernel 2.5.19 oops when copying files from SMBFS fs to
 VFAT fs
In-Reply-To: <F40TalaQXGuHVVbkCf00000e3b1@hotmail.com>
Message-ID: <Pine.LNX.4.33.0205302345160.4267-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Felipe Alfaro Solana wrote:

> Starting with linux kernel 2.5.19, when I try to cp/mv files from one of my 
> Windows 2000, Service Pack 2 machines (mounted as SMBFS on 
> /net/gateway-data) to a local VFAT partition (mounted as VFAT on /mnt/data), 
> causes the kernel to oops.
> 
> Please, see attached "dmesg" file for information on the kernel oops 
> message. Also, the "ksymoops" file contains the information dumped by 
> ksymooops on the faulting kernel.

It appears to crash in smbfs smb_readpage because struct file is NULL.
Don't know if that is a caller error or a smbfs bug.


> Steps to reproduce the problem:
> ===============================
> mount -t vfat /dev/hda3 /mnt/data -o gid=100,umask=007
> mount -t smbfs //gateway/data /net/ -o username=Administrator
> /mnt/data/Jpgs/
> cp /net/* .

Approximately how much data is this?
Does this also happen with a kernel in the stable series? (2.4.19-pre9 ?)

/Urban

