Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbUAGUMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUAGUMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:12:41 -0500
Received: from lmdeliver01.st1.spray.net ([212.78.202.210]:34728 "EHLO
	lmdeliver01.st1.spray.net") by vger.kernel.org with ESMTP
	id S265610AbUAGUMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:12:39 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Wed, 7 Jan 2004 21:12:35 +0100
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <200401071559.16130.ornati@lycos.it> <1073503421.10018.17.camel@dyn319250.beaverton.ibm.com>
In-Reply-To: <1073503421.10018.17.camel@dyn319250.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401072112.35334.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 January 2004 20:23, Ram Pai wrote:
>
> I tried on my lab machine with scsi disks. (I dont have access currently
> to a spare machine with ide disks.)
>
> I find that reverting the changes in mm/filemap.c and then reverting the
> lazy-read optimization gives much better sequential read performance on
> blockdevices.  Is this your observation on IDE disks too?

Yes and No.
I have only tried to revert lazy-read optimization (without any visible 
change) so I have reapplied it AND THAN I have reverted changes in 
mm/filemap.c... and performance has gone back.

>
> > I don't know why... but it does.
>
> Lets see. I think my theory is partly the reason. But the changes in
> filemap.c seems to be influencing more.

YES, I agree.
I haven't done a lot of tests but it seems to me that the changes in 
mm/filemap.c are the only things that influence the sequential read 
performance on my disk.

-- 
	Paolo Ornati
	Linux v2.4.23

