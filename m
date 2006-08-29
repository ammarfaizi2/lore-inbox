Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWH2Frm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWH2Frm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWH2Frm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:47:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:39817 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751115AbWH2Frl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:47:41 -0400
Subject: Re: Reiser4 und LZO compression
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Edward Shishkin <edward@namesys.com>,
       Stefan Traby <stefan@hello-penguin.com>,
       Hans Reiser <reiser@namesys.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, nitingupta.mail@gmail.com
In-Reply-To: <20060829045937.GA9181@localhost.hsdv.com>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
	 <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com>
	 <44F332D6.6040209@namesys.com> <1156801705.2969.6.camel@nigel.suspend2.net>
	 <20060829045937.GA9181@localhost.hsdv.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:47:15 +1000
Message-Id: <1156830435.3790.21.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-08-29 at 13:59 +0900, Paul Mundt wrote:
> On Tue, Aug 29, 2006 at 07:48:25AM +1000, Nigel Cunningham wrote:
> > For Suspend2, we ended up converting the LZF support to a cryptoapi
> > plugin. Is there any chance that you could use cryptoapi modules? We
> > could then have a hope of sharing the support.
> > 
> Using cryptoapi plugins for the compression methods is an interesting
> approach, there's a few other places in the kernel that could probably
> benefit from this as well, such as jffs2 (which at the moment rolls its
> own compression subsystem), and the out-of-tree page and swap cache
> compression work.
> 
> Assuming you were wrapping in to LZF directly prior to the cryptoapi
> integration, do you happen to have before and after numbers to determine
> how heavyweight the rest of the cryptoapi overhead is? It would be
> interesting to profile this and consider migrating the in-tree users,
> rather than duplicating the compress/decompress routines all over the
> place.

I was, but I don't have numbers right now. I'm about to go out, but will
see if I can find them when I get back later. From memory, it wasn't a
huge change in terms of lines of code.

Regards,

Nigel

