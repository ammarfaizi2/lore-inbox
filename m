Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVGRIoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVGRIoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 04:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVGRIoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 04:44:04 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:58552 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S261248AbVGRIoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 04:44:02 -0400
In-Reply-To: <17110.32325.532858.79690@tut.ibm.com>
Subject: Re: Merging relayfs?
Sensitivity: 
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       karim@opersys.com, linux-kernel@vger.kernel.org, varap@us.ibm.com,
       zanussi@us.ibm.com, Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OF7583808A.476011C9-ON41257042.002F3434-41257042.002FA176@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Mon, 18 Jul 2005 09:40:15 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 18/07/2005 09:44:00
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Tom Zanussi <zanussi@us.ibm.com> wrote on 14/07/2005 16:01:25:


> The only things that are atomic are the counts of produced and
> consumed buffers and these are only ever updated or read in the slow
> buffer-switch path.  They're atomic because if they weren't, wouldn't
> it be possible for the client to read an unfinished value if the
> producer was in the middle of updating it?


This depends on architecture.  It is possible under some architectures to
see the so-called score-boarding effect when reading on one processor while
writing on another when not having imposed any atomicity. From memory, I
believe this might be possible with zSeries, but I'll need to check the
microarchitecture docs. It's been a long time since I read them but I do
recall a reference to the score-boarding effect.


>  ...


Richard


- -
Richard J Moore
IBM Advanced Linux Response Team - Linux Technology Centre
MOBEX: 264807; Mobile (+44) (0)7739-875237
Office: (+44) (0)1962-817072

