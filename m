Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVFZRjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVFZRjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFZRjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:39:15 -0400
Received: from alpha.polcom.net ([217.79.151.115]:1953 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261491AbVFZRi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:38:57 -0400
Date: Sun, 26 Jun 2005 19:38:42 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
In-Reply-To: <1119806434.28644.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0506261931210.7125@alpha.polcom.net>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> 
 <42BB31E9.50805@slaphack.com>  <1119570225.18655.75.camel@localhost.localdomain>
  <42BB7B32.4010100@slaphack.com>  <1119612849.17063.105.camel@localhost.localdomain>
  <42BC5D2E.1070307@namesys.com> <1119806434.28644.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005, Alan Cox wrote:

> On Gwe, 2005-06-24 at 20:21, Hans Reiser wrote:
>> Alan, this is FUD.   Our V3 fsck was written after everything else was,
>> for lack of staffing reasons (why write an fsck before you have an FS
>> worth using).  As a result, there was a long period where the fsck code
>> was unstable.  It is reliable now.
>>
>> People often think that our tree makes fsck less robust.  Actually fsck
>> can throw the entire internal tree away and rebuild from leaf nodes, and
>> frankly that makes things pretty robust.
>
> I did a series of tests well after resier3 had fsck that consisted of
> modelling the behaviour of systems under error state. I modelled random
> bit errors, bit errors at a fixed offset (class ram failure), sector 4
> byte slip (known IDE fail case) and sectors going away.
>
> Reiserfs didn't handle it anything like as gracefully as ext2. Its a
> pretty easy experiment to write the code for and the results are
> interesting.

Maybe but I once checked some other error scenario. I generated (by 
mistake of course) dm table that lineary connected 3 times the same 
partition (instead of 3 different partitions). Both Reiser4 and Reiserfs3 
gave a lot of errors while trying to use such device. Ext3 did not give 
single error and was hapily droping my data,

I agree that this is not very useful test case for disk problems but it 
shows that, at least, checks for trouble in Reiser4 are miles before those 
in Ext2/3. If only Reiser4 could print a note what I done wrong... ;-)


Grzegorz Kulewski
