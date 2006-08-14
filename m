Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWHNNt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWHNNt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWHNNt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:49:58 -0400
Received: from erik-slagter.demon.nl ([83.160.41.216]:8644 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751421AbWHNNt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:49:58 -0400
Subject: Re: md mirror / ext3 / dual core performance strange phenomenon?
From: Erik Slagter <erik@slagter.name>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155564114.24077.212.camel@localhost.localdomain>
References: <1155561134.7809.27.camel@skylla.slagter.name>
	 <1155564114.24077.212.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 15:49:56 +0200
Message-Id: <1155563396.7809.39.camel@skylla.slagter.name>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ma, 2006-08-14 at 15:01 +0100, Alan Cox wrote:
> Ar Llu, 2006-08-14 am 15:12 +0200, ysgrifennodd Erik Slagter:
> > I am really blown away here. It looks like disk access is the bottleneck
> > here, but I can't imagine my disks being so slow (at seeking, I guess)
> > it should matter that much.
> 
> Keith has answered the main question but your assumptions about seeking
> are also not neccessarily correct. Disk seek times as opposed to data
> rates and density have not materially improved for many years now, nor
> for IDE has the rotation speed and thus rotational latency to access
> data.

I was suspecting disk seeking because increasing the number of jobs
(beyond the number of cores) would help. But I really didn't take the
actual kernel building system into consideration. And I do know that ATA
disk seek performance is ehrrmm... suboptimal and absolutely not related
to interface speed or even straight read-from-disk speed. I was hoping
fiddling with the i/o scheduler and readahead knobs would make _some_
difference here.

Interesting fact btw, that if I kick one of the disks out of the mirror,
the kernel building time remains more or less the same. So it looks like
the md mirror theory doesn't have that great impact on practise.

Anyway thank for the clues.

