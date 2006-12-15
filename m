Return-Path: <linux-kernel-owner+w=401wt.eu-S1750728AbWLOAWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWLOAWN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWLOAWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:22:13 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:36599 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbWLOAWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:22:12 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 19:12:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Miguel Ojeda <maxextreme@gmail.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <653402b90612141516w46e4a623u21ba34f9664f392c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612141911240.27384@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <653402b90612141516w46e4a623u21ba34f9664f392c@mail.gmail.com>
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

On Fri, 15 Dec 2006, Miguel Ojeda wrote:

> On 12/13/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> >
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
> Maybe *(x) instead of (x)[0]?

yeah, there's a bunch of that, too:

  $ grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\*\1\)" .

easy enough to catch using the same technique.

rday
