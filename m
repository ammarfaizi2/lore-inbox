Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318864AbSHRG0z>; Sun, 18 Aug 2002 02:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318865AbSHRG0z>; Sun, 18 Aug 2002 02:26:55 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:50194
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318864AbSHRG0z>; Sun, 18 Aug 2002 02:26:55 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 02:31:02 -0400
Message-Id: <1029652262.898.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 00:01, Linus Torvalds wrote:

> So I think that if we just made the code be much less trusting (say, 
> consider the TSC information per interrupt to give only a single bit of 
> entropy, for example), and coupled that with making network devices always 
> be considered sources of entropy, we'd have a reasonable balance. 

I think that sounds good.

I have a patch which I can send - it needs to be rediffed I suspect -
that has each network device feed the entropy pool. (Actually, it
creates a new flag, SA_NET_RANDOM, that defines to SA_SAMPLE_RANDOM or 0
depending on a configure setting.  If you want it unconditional, that is
just as easy though).

	Robert Love

