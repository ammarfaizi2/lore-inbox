Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVANHfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVANHfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 02:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVANHfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 02:35:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:17930 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261415AbVANHfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 02:35:31 -0500
Subject: Re: propolice support for linux
From: Arjan van de Ven <arjan@infradead.org>
To: Han Boetes <han@mijncomputer.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050113193205.GE14127@boetes.org>
References: <20050113134620.GA14127@boetes.org>
	 <20050113140446.GA22381@infradead.org> <20050113163733.GB14127@boetes.org>
	 <1105635755.6031.37.camel@laptopd505.fenrus.org>
	 <20050113193205.GE14127@boetes.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 08:35:20 +0100
Message-Id: <1105688121.6080.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well I suggest it here as well:
>   http://forums.mozillazine.org/viewtopic.php?t=199891
> 
> But got zero replies. Could you be so kind to point out to these
> people it's a good idea?


there are other alternatives to PP that don't require code changes; for
example Jakub wrote a patch for gcc4 and 3.4 that has the effect of
detecting buffer overflows but that
1) Does not require code changes in userspace (only CFLAGS)
2) is supposedly better in line with the gcc architecture (but I'm not a
gcc export to judge that)

Before people say "NIH NIH NIH" I have to say this: Propolice is a great
piece of work. But if it's architecture is not suitable for gcc mainline
(especially with the SSA changes in gcc4) then it's most likely not
going anywhere (as a way of "proof": PP is around for a long time, but
it still hasn't made gcc mainline, I don't even know if it has been
submitted for that even). The functionality of detecting buffer
overflows is useful, and Jakubs patch addresses that functionality as
well, but in a way that is more in line with the gcc design. 
(It's actually quite cool stuff, current rawhide is getting compiled
with it for example and working quite nicely there)


