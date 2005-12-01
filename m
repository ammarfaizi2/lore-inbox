Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVLAWqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVLAWqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVLAWqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:46:42 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:2525 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S932539AbVLAWqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:46:42 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for benchmarks
To: Dirk Henning Gerdes <mail@dirk-gerdes.de>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Thu, 01 Dec 2005 23:48:22 +0100
References: <5f08L-Um-413@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EhxDz-0001BT-Af@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:

> For doing benchmarks on the I/O-Schedulers, I thought it would be very
> useful to disable the pagecache.
> 
> I didn't want to make it so complicated so I just mark pages as
> not-uptodate, so they have to be read again. Another reason was, that I
> wanted to keep the conditions as near to reality as possible.
> 
> Further I thought it would be useful, if you could turn the pagecache on
> and off without rebooting the system.
> 
> I implemented a proc-fs entry "/proc/benchmark/pagecache" for this.

1) This mail is the only documentation on how to operate your patch.
   How do you suppose your users to find out how to operate the switch?
   (I asume it's really a switch, a toggle would be insane.)

   Since it's very short and only for special purpose, documenting it
   in Kconfig mignt be enough.

2) You're seperating your patches by file, not by function. ungood.

3) Your patches introduce a lot of whitespace.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
