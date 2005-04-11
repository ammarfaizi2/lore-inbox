Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVDKP23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVDKP23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDKP22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:28:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21182 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261801AbVDKP2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:28:23 -0400
Date: Mon, 11 Apr 2005 17:28:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-ID: <20050411152815.GB5562@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411074552.4e2e656b.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


here are some stats: of the last 34160 files modified in the Linux 
kernel tree in the past 1 year, the file sizes total to 1 GB, and the 
average file-size per file committed is 31220 bytes. The changes 
themselves amount to:

 22404 files changed, 1996494 insertions(+), 1396644 deletions(-)

(the # of files changed is lower because one file can be modified 
multiple times)

the Linux kernel has an average line-length of 36 bytes, so even without 
analyzing the commits themselves, the actual size of changes is around 
70 MB content added, 50 MB content removed. The patches (plus commit 
comments, and email headers) add up to 250 MB.

So the combo-blob representation would have an uncompressed content 
somewhere between 130MB and 250MB: 200 MB would be a good guess i think.  
That's 20% of the 1+ GB the full-blob representation would give, and it 
would be nearly as compressible.

	Ingo
