Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUE1VHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUE1VHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUE1VHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:07:37 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:41739 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261680AbUE1VHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:07:33 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Paul Serice <paul@serice.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Help with Non-Unique Inodes
Date: Sat, 29 May 2004 00:07:14 +0300
User-Agent: KMail/1.5.4
References: <40B74DFF.9090402@serice.net>
In-Reply-To: <40B74DFF.9090402@serice.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405290007.14726.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 May 2004 17:34, Paul Serice wrote:
> I think I've finished changing the inode scheme in the isofs code to
> better support DVDs.  Pursuant to a comment in fs/inode.c, I switched
> from iget() to iget5_locked() because a 32-bit inode number was unable
> to uniquely identify all the possible inodes.
>
> I want to make sure I understand what is expected of the ino_t value
> returned to the user before I post the patch:
>
> 1) Does the ino_t returned to the user have to be unique? I ask
>     because the inodes on the isofs are sparse, and a unique number
>     could probably be generated for the benefit of the user.  I'm
>     currently returning the same hash value I pass to iget5_locked().
>
> 2) In order to avoid recursion loops, I believe the "ls" and "find"
>     commands assume inodes are unique for a particular device, and they
>     refuse to recurse down different directories on the same device
>     with the same inode number.  If the ino_t returned to the user does
>     not have to be unique, how do I guarantee that these basic
>     utilities are capable of fully recursing the file system?

inaodes are 32bit and shall be unique.

I wonder, thugh, how Linux will manage to achieve that on
exabyte-sized drives and filesystems five years from now...
--
vda

