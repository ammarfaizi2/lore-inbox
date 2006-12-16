Return-Path: <linux-kernel-owner+w=401wt.eu-S1753663AbWLPNNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbWLPNNg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753666AbWLPNNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:13:36 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:42534 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbWLPNNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:13:35 -0500
X-Originating-Ip: 24.148.236.183
Date: Sat, 16 Dec 2006 08:09:25 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Pavel Machek <pavel@ucw.cz>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <20061216084007.GC4049@ucw.cz>
Message-ID: <Pine.LNX.4.64.0612160802250.3660@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <20061216084007.GC4049@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Pavel Machek wrote:

> Hi!
>
> >   there are numerous places throughout the source tree that apparently
> > calculate the size of an array using the construct
> > "sizeof(fubar)/sizeof(fubar[0])". see for yourself:
> >
> >   $ grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" *
> >
> > but we already have, from "include/linux/kernel.h":
> >
> >   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>
> Hmmm. quite misleading name :-(. ARRAY_LEN would be better.

i suspect it's *way* too late to make that kind of change, given that
"ARRAY_SIZE" is firmly ensconced in countless places in the source
tree and that would be a major, disruptive change.

even *i* wouldn't try to promote that idea.  :-)

rday
