Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWAAN2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWAAN2x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 08:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWAAN2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 08:28:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50139 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932166AbWAAN2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 08:28:53 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Arjan van de Ven <arjan@infradead.org>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5a2cf1f60601010412r3ec10855s5ad6ed8e0a6f2ef1@mail.gmail.com>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <20060101115121.034e6bb7@galactus.example.org>
	 <1136114772.17830.20.camel@laptopd505.fenrus.org>
	 <5a2cf1f60601010412r3ec10855s5ad6ed8e0a6f2ef1@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 14:28:49 +0100
Message-Id: <1136122129.17830.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 13:12 +0100, jerome lacoste wrote:
> On 1/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > >
> > > DO YOU REALLY PREFER USERS NOT REPORT BUGS?
> 
> [...]
> 
> > So getting back to your question:
> > I would say that I think it's generally better that bugs that cannot be
> > reproduced on an untainted kernel are not reported on lkml, but reported
> > to the vendor of the tainting module instead, simply because it's very
> > likely that it'll waste precious debug time.
> 
> Although I like the idea of making the vendors of binary modules
> really aware of the costs they introduce with regard to debug issues
> on tainted system, if I was them, the first thing I would say is
> "contact the vendor of the part of the system that changed", i.e. the
> kernel.

btw you do have a point; should nvidia care if someone patches their
kernel with the -rt patchkit, something which changes many rules inside
the kernel. I'm actually surprised such binary modules work *at all*
given how many of the rules have changed. (For source-compiled modules
it's a bit less of a surprise since the api changes get compiled
through, eg most of the cases the API stayed the same the ABI didn't ,
for binary ones.. that only works if you're lucky I guess. Even for
source modules several needed changes (just look at the -rt patchkit) ).

To some degree, if you use binary modules and experimental patches, you
are on your own; the module vendor is unlikely to care, but so are most
of the developers of the patchkits.. (after all.. there is a good reason
-rt has different rules, that is the whole POINT of the -rt patches,
different rules to achieve the goal of extremely low latencies)


