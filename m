Return-Path: <linux-kernel-owner+w=401wt.eu-S932207AbXAIQ2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbXAIQ2S (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbXAIQ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:28:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51343 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204AbXAIQ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:28:16 -0500
Date: Tue, 9 Jan 2007 08:23:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Fengguang Wu <fengguang.wu@gmail.com>
cc: Theodore Tso <tytso@mit.edu>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
       "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: How git affects kernel.org performance
In-Reply-To: <368329554.17014@ustc.edu.cn>
Message-ID: <Pine.LNX.4.64.0701090821550.3661@woody.osdl.org>
References: <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org>
 <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org>
 <368329554.17014@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2007, Fengguang Wu wrote:
> > 
> > The fastest and probably most important thing to add is some readahead
> > smarts to directories --- both to the htree and non-htree cases.  If
> 
> Here's is a quick hack to practice the directory readahead idea.
> Comments are welcome, it's a freshman's work :)

Well, I'd probably have done it differently, but more important is whether 
this actually makes a difference performance-wise. Have you benchmarked it 
at all?

Doing an

	echo 3 > /proc/sys/vm/drop_caches

is your friend for testing things like this, to force cold-cache 
behaviour..

		Linus
