Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSD3MeR>; Tue, 30 Apr 2002 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313304AbSD3MeQ>; Tue, 30 Apr 2002 08:34:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15374 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313300AbSD3MeO>; Tue, 30 Apr 2002 08:34:14 -0400
Message-Id: <200204301217.g3UCGtX02871@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Nikita Danilov <Nikita@Namesys.COM>, Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Date: Tue, 30 Apr 2002 15:19:17 -0200
X-Mailer: KMail [version 1.3.2]
Cc: viro@math.psu.edu, Jan Harkes <jaharkes@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020427191820.04003500@pop.cus.cam.ac.uk> <5.1.0.14.2.20020429115231.00b1d900@pop.cus.cam.ac.uk> <15565.13742.140693.146727@laputa.namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 April 2002 09:59, Nikita Danilov wrote:
> Anton Altaparmakov writes:
>  > Al, would you agree with NTFS using ->read_inode2 as well as ReiserFS?
>
> ->read_inode2 is a hack. And especially so is having both ->read_inode
> and ->read_inode2. iget() interface was based on the assumption that
> inodes can be located (and identified) by inode number. It is not so at
> least for the reiserfs and ->read_inode2 works around this by passing
> "cookie" with information sufficient for file system to locate inode.

Why do we have to stich to concept of inode *numbers*?
Because there are inode numbers in traditional Unix filesystems?

What about reiserfs? NTFS? Even plain old FAT have trouble simulating
inode numbers for zero-length files.

Why? Because inode numbers (or lack of them) is fs implementation detail 
which unfortunately leaked into Linux VFS API.

Or maybe I am just stupid.
--
vda
