Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUB0Ucl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbUB0Ucl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:32:41 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:19424 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263121AbUB0Uca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:32:30 -0500
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: harddisk speed: 2.4.24 20+% faster then 2.6.3
Date: Fri, 27 Feb 2004 20:32:28 +0000 (UTC)
Organization: Cistron
Message-ID: <c1o9gs$imc$1@news.cistron.nl>
References: <c1m1id$u31$1@news.cistron.nl> <20040227200459.GO3925@squish.home.loc>
X-Trace: ncc1701.cistron.net 1077913948 19148 62.216.30.38 (27 Feb 2004 20:32:28 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul  <set@pobox.com> wrote:
>By default, my hdparm numbers and my kernel build time
>benchmark were worse on all 2.6 vs. 2.4 kernels, until I tried:
>/sbin/hdparm -a 4096 /dev/hdx
>eg. (typical averages)
>2.4.21:
>Timing buffered disk reads:   80 MB in  3.07 seconds =  26.06 MB/sec
>2.6.0-test5:
>Timing buffered disk reads:   68 MB in  3.06 seconds =  22.21 MB/sec
>2.6.1: [readahead 4096]
>Timing buffered disk reads:   90 MB in  3.02 seconds =  29.82 MB/sec

Allready thought about that, tried that but no real

difference:belfish:~# uname -a
Linux babelfish 2.6.3-mm4 #3 Fri Feb 27 14:09:38 CET 2004 i686 GNU/Linux

babelfish:~# /sbin/hdparm -a 4096 /dev/hda
/dev/hda:
setting fs readahead to 4096
readahead    = 4096 (on)

babelfish:~# hdparm -t /dev/hda
Timing buffered disk reads:  110 MB in  3.02 seconds =  36.47 MB/sec

I just installed a news amd64 en few 19" servers.
But none of them showed downgrade in performance when i upped the
kernel.

Possibilities left (according to me!)

- scheduler (should i try different setup ?)
- irq problems (in combination with acpi?)
  i booted with acpi=off and retested but same results.
- driver, specific the via-onboard.

No luck so far!

Danny
-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

