Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUKGMQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUKGMQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 07:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUKGMQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 07:16:49 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:16107 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261584AbUKGMQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 07:16:42 -0500
Date: Sun, 7 Nov 2004 13:16:37 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Patrick McHardy <kaber@trash.net>
Cc: Pablo Neira <pablo@eurodev.net>, Matthias Andree <matthias.andree@gmx.de>,
       linux-net@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps
Message-ID: <20041107121637.GC29510@merlin.emma.line.org>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Pablo Neira <pablo@eurodev.net>, linux-net@vger.kernel.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
References: <20041104121522.GA16547@merlin.emma.line.org> <418A7B0B.7040803@trash.net> <20041104231734.GA30029@merlin.emma.line.org> <418AC0F2.7020508@trash.net> <418BE156.4020400@eurodev.net> <418BFC5C.20201@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418BFC5C.20201@trash.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Nov 2004, Patrick McHardy wrote:

> What if the C is the last byte ? There are also more str* commands below
> that need a terminating 0-byte.

IMNSHO, str* functions have no business in arbitrary data. I have a
simple memstr() function in bogofilter that is GPL'd and can be imported
into the kernel, I believe:

http://cvs.sourceforge.net/viewcvs.py/*checkout*/bogofilter/bogofilter/src/memstr.c?rev=HEAD

Yes, there is room for optimization, but as long as strstr isn't
optimized, who cares.

-- 
Matthias Andree
