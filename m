Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTFJJG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFJJG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:06:26 -0400
Received: from [217.222.53.238] ([217.222.53.238]:53252 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S262439AbTFJJGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:06:24 -0400
Message-ID: <3EE5A2C3.1060303@gts.it>
Date: Tue, 10 Jun 2003 11:20:03 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE performances, 2.4 vs 2.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Noting that 2.5 is much slower than 2.4 on disk operations (you *touch* 
it when you have not-so-fast machine and use KDE, for example), I've 
written a silly test that fwrite/fread a single 100Mb file, char by 
char, and timing it I have results that I can't understand very well. Of 
course, same machine, same hdparm settings, same processes running 
(none, it's a notebook without server processes). I've run these test 
several time, the results are always more or less the same (ext2):

2.4.19

   read:    real    0m15.822s
            user    0m15.180s
            sys     0m0.270s

   write:   real    0m12.524s
            user    0m11.800s
            sys     0m0.690s

2.5.70 (up to -bk14, and -mm6)

   read:    real    0m20.790s
            user    0m14.372s
            sys     0m0.949s

   write:   real    0m13.148s
            user    0m11.901s
            sys     0m0.665

Writing does not drop, but reading has a 6 seconds difference between 
user+sys and real that I can't figure out. And the total difference is 
"huge". Actually, using anything that touches the disk (it can be a 
trivial "aptitude" loading the cache, or a complex KDE) slows down.

I've run these tests on a HP Omnibook w/Celeron, but I have the same 
slow down on a Athlon K7.

Is it anyway "normal", something I should expect upgrading from 2.4 to 
2.5/2.6? Or there should be something I should check more accurately?

Bye all.

-- 
Stefano RIVOIR




