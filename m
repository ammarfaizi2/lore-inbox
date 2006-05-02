Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWEBLkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWEBLkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWEBLkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:40:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:38841 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964783AbWEBLkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:40:12 -0400
Date: Tue, 2 May 2006 13:39:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
In-Reply-To: <1146560129.32045.25.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0605021338440.17510@yvahk01.tjqt.qr>
References: <20060502075049.GA5000@mail.ustc.edu.cn> 
 <1146556724.32045.19.camel@laptopd505.fenrus.org>  <20060502080619.GA5406@mail.ustc.edu.cn>
  <1146558617.32045.23.camel@laptopd505.fenrus.org>  <20060502085325.GA9190@mail.ustc.edu.cn>
 <1146560129.32045.25.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Another interesting approach would be to actually put all the data you
>> > want to use in a non-fragmented, sequential area on disk somehow (there
>> > is an OLS paper submitted about that by Ben) so that at least the disk
>> > side is seekless... 
>> 
>> You are right, reducing seeking distances helps not much. My fluxbox
>> desktop requires near 3k seeks, which can be loaded in the 20s init.d
>> booting time.  But for KDE/GNOME desktops, some defragging would be
>> necessary to fit them into the 20s time span.
>
>or just move the blocks (or copy them) to a reserved area...

Or even put it into a ramdisk, and then fix userspace. When Gnome loads 
more than 10000 files [http://kerneltrap.org/node/2157], it sounds like a 
design problem.


Jan Engelhardt
-- 
