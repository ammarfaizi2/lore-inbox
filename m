Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264512AbRFJJDX>; Sun, 10 Jun 2001 05:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264511AbRFJJDN>; Sun, 10 Jun 2001 05:03:13 -0400
Received: from beasley.gator.com ([63.197.87.202]:274 "EHLO beasley.gator.com")
	by vger.kernel.org with ESMTP id <S264512AbRFJJDB>;
	Sun, 10 Jun 2001 05:03:01 -0400
From: "George Bonser" <george@gator.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.6-pre2 page_launder() improvements
Date: Sun, 10 Jun 2001 02:06:09 -0700
Message-ID: <CHEKKPICCNOGICGMDODJKEJNDEAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.33.0106100541200.1742-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> That sounds like the machine just gets a working set
> larger than the amount of available memory. It should
> work better with eg. 96, 128 or more MBs of memory.

Now that I think about it a little more ... once I took it out of the
balancer and I got control back, I had over 500 apache kids alive and it was
responsive.  Also, when top -q starting giving out, it was still updating
the screen though it started getting slower and slower ... at that point I
only had MAYBE 300 apache processes. It almost felt like the system could
not catch up as fast as the new connections were arriving. Lets say it "goes
dead" at about 300 or so connections, I let it run for a while then take it
out of the rotation and it "comes back" and shows me it has about 500
processes and its interactive response is fine and it is only about 100MB
into swap. It just feels like it can't get out of its own way fast enough.

