Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbTF3Qy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTF3Qy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:54:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:27028 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265452AbTF3Qyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:54:55 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: "Leonard Milcin Jr." <thervoy@post.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
Date: Mon, 30 Jun 2003 12:04:03 -0500
User-Agent: KMail/1.5
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <bdpn3c$te5$1@tangens.hometree.net> <3F006C76.7010308@post.pl>
In-Reply-To: <3F006C76.7010308@post.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306301204.03852.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 11:59, Leonard Milcin Jr. wrote:
> Henning P. Schmiedehausen wrote:
> > "David D. Hagood" <wowbagger@sktc.net> writes:
> >>For example, suppose you have a 60G disk, 55G of data, in ext2, and you
> >>wish to convert to ReiserFS.
> >>
> >>
> >>Step 1: Shrink the volume to 55G. This requires a "shrink disk" utility
> >>for the source file system (which exists for the major file systems in
> >>use today).
> >
> > You have a 6 GB file. You lose. :-)
> >
> > 	Regards
> > 		Henning
>
> Hey folk! I don't used LVM, but I think it allows file to be splitted
> between diferent filesystems. Yes?

Um, no. Volume managers allow you to span a volume across multiple disks. But 
a filesystem (and thus all of its files) is still fully contained within a 
single volume. IOW, volume management is a method for managing block-devices. 
Filesystems are a method for managing files. There is a distinct line between 
them.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

