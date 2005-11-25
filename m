Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVKYW75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVKYW75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVKYW75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:59:57 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:10657 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932264AbVKYW74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:59:56 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: defective RAM: corrupted ext3 FS. How to identify corrupted files/directories?
To: jerome lacoste <jerome.lacoste@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 25 Nov 2005 23:49:43 +0100
References: <5cJ9S-44L-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EfmO0-0000rX-KE@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:

> My RAM died, and it corrupted my file system. It seems like this
> machine just wants to die... [1]
> 
> After removing the faulty RAM, I can boot. I made extensive memtest86+ tests.
> I now have my home partition mounted as read-only because of said corruption.
> 
> I see a bunch of "ext3_readdir: directory xxxx contains a hole at
> offset xxxxx"  when I try to access some parts of my disk.
> 
> I postponed fscking the FS until I have identified the faulty data.
> 
> I was thinking of doing a rsync --dry-run against a known working
> backup and check the logs. Any better idea? Is there a way to convert
> the directory IDs into file paths?
> 
> I have around 500 000 files on that partition. It takes time checking them
> all.

1) Use the backup to get a base on a completely seperate HDD.
1a) Feel glad about having a backup.
2) Find new and changed files on the corrupted disk.
3) For each of the files found, inspect it's contents and copy it over
   if it's non-corrupted. You can't automatically find corrupted files
   unless you know otherwise.
4) mkfs
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
