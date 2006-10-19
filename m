Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWJSJvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWJSJvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWJSJvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:51:32 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:8683 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161372AbWJSJvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:51:31 -0400
Date: Thu, 19 Oct 2006 11:48:24 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       jlamanna@gmail.com, ismail@pardus.org.tr
Subject: Re: [PATCH] Support ISO-9660 RockRidge v. 1.12 V2
Message-ID: <453749e8.ANSGHhMt8ZPpaILR%Joerg.Schilling@fokus.fraunhofer.de>
References: <45365825.05759a90.7d7c.ffffe441@mx.google.com>
In-Reply-To: <45365825.05759a90.7d7c.ffffe441@mx.google.com>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Lamanna <jlamanna@gmail.com> wrote:

>
> Joerg Schilling pointed out that RockRidge v. 1.12 extends the PX entry.
> This patch stores the inode number that is now included.
> He has also mentioned 'implementing support for new inode features' wrt to a
> mkisofs fingerprint. Perhaps that will come at a later date.
> Regardless, that can be built on this patch since now the inode number gets
> stored.
>
> This patch has been tested against mounting an ISO-9660 image in
> loopback that supports RockRidge v. 1.12 (thank you to Joerg for a beta 
> of mkisofs that does this).
> This should apply against the latest git.

Let me add some more notes:

The linux NFS server interface is unnecessarily complex and will make it 
a lot harder than a "single line change" to make the filesystem correct in case
Linux likes to benefit from the inode numbers in RRip 1.12 to support correct 
hardlinks. 

If you believe that you understand the NFS server issues, you should fix the 
code so that NFS exports will work correctly after the change. If you don't know
what's going on there, you may need to spend a few days with testing and 
debugging.

Note that you need to be able to "re-open" any file from a NFS file handle only...
There are many constraints that need to be redeemed and the new algorithm needs 
to work correctly with old and with new media.


And finally a note to Alan Cox:

Instead of being unwilling to follow the Nettiquette by removing people from the
To: list with your replies and instead of sending useless replies that don't help
people, you should better stay quiet.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
