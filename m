Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUI0DkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUI0DkS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 23:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUI0DkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 23:40:18 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:34692 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265768AbUI0DkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 23:40:09 -0400
Message-ID: <d91f4d0c040926204019fde277@mail.gmail.com>
Date: Sun, 26 Sep 2004 23:40:05 -0400
From: George Georgalis <georgalis@gmail.com>
Reply-To: George Georgalis <georgalis@gmail.com>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       George Georgalis <george@galis.org>
Subject: Re: [PATCH] fix sata_sil quirk
Cc: Ricky Beam <jfbeam@bluetronic.net>, linux-ide@vger.kernel.org
In-Reply-To: <20040628015431.GA31687@trot.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <40D8FE55.3030008@pobox.com>
	 <Pine.GSO.4.33.0406230230010.25702-100000@sweetums.bluetronic.net>
	 <20040628015431.GA31687@trot.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 21:54:31 -0400, George Georgalis <george@galis.org> wrote:
> On Wed, Jun 23, 2004 at 02:34:35AM -0400, Ricky Beam wrote:
> >
> >That list needs a:
> >         { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
> >as well.
> 
> happens to be my drive, is there any way to tell a drive needs
> be in the quirk 15 list, other than it's Seagate and big writes
> block the dev?


Actually my problem with big writes was the bk kernel I downloaded was
a rev too early (2.6.7-bk7 ?).

I tested the sata_sil.c version from June 25 (via bk checkout)
extensively and had no problem... posted my results then, hdparm
reported ~42 - 51 MB/sec, and never a write block.

Today I try putting 2.6.8.1 on the box and I'm getting ~14 MB/sec, the
drive has been added to the sil_blacklist. Why? What did I miss?

I've taken my drive out of the black list, abused it with 5 continuous
writes and "top id 0" no problem after 58Gb. I'm doing it again this
time simultaneously with a massive rm -rf of backup directories. I
really don't anticipate a problem.

So what's up with 

         /*{ "ST3160023AS",      SIL_QUIRK_MOD15WRITE },*/

before it got in there, it was said the black list "would not grow"
(for unexplained reasons).

// George

-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
