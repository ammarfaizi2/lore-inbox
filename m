Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWBYOhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWBYOhf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWBYOhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:37:35 -0500
Received: from dze141s31.ae.poznan.pl.220.254.150.in-addr.arpa ([150.254.220.184]:55980
	"EHLO dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S1030260AbWBYOhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:37:34 -0500
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.1 AWL                    AWL: From: address is in the auto white-list
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(85.221.144.160):SA:0(-3.9/2.5):. Processed in 0.827729 secs Process 25186)
Date: Sat, 25 Feb 2006 15:37:49 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1271316508.20060225153749@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
CC: reiserfs-list@namesys.com
Subject: creating live virtual files by concatenation
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have this idea about creating sort of a virtual file.

Let us say I have three text files that contain javascript code:
tooltip.js
banner.js
foo.js

Now let us say I am creating sort of a virtual text file (code.js)
that is a live-concatenation of these files:
# concatenate tooltip.js banner.js foo.js code.js

Note I am not talking about the cat(1) utility. I am thinking of
code.js be always a live concatenated version of these three, so when
I modify one file, the live-version is also modified.

What puprose I might have? Network-related. Say, I have an HTML file
that includes these three files in its code.

When a browser downloads the HTML file it will then create three threads
to download each of those javascript files.

If I had a live-concatenated file, I could reference it in the HTML file
so that the browser does not have to download three files but just one.

This would surely reduce network overhead of downloading the same amount
of data but within just one connection, reduce resource usage on the client
and possibly (depending on implementation) reduce the cost of accessing
three individual files on the server.

I am CC'ing reiserfs-list because Reiser4 would seem to be the most
robust filesystem that could have it done.

Any thoughts about the idea itself?
Would be nice if this idea could inspire some talented hackers here and there.

Best Regards,
Maciej


