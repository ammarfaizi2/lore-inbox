Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbVJLPow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbVJLPow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVJLPow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:44:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24456 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751470AbVJLPov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:44:51 -0400
Subject: Re: using segmentation in the kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Brian Gerst <bgerst@didntduck.org>,
       "Jonathan M. McCune" <jonmccune@cmu.edu>, linux-kernel@vger.kernel.org,
       Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>
In-Reply-To: <1129133231.7966.1.camel@localhost.localdomain>
References: <434C1D60.2090901@cmu.edu> <434C2269.5090209@didntduck.org>
	 <434C1F8E.6080405@gmail.com>
	 <1129107936.3082.34.camel@laptopd505.fenrus.org>
	 <1129133231.7966.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 17:44:33 +0200
Message-Id: <1129131873.3082.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > and I don't believe this one yota. THe only way to do this is to run
> > modules in ring 1, at which point you are in deep shit anyway.
> 
> Not neccessarily. Its how Xen works on x86-32 for example. It keeps
> itself protected from the entire Linux instance by using segmentation on

it only works if you make a very small syscall-like area which you use
to talk to the "real" kernel. Which is entirely not how linux modules
work right now.... at which point you're just about a userspace
application anyway. Might be an interesting research project of
course...


> 32bit processors (not 64bit however as x86-64 has no segments in 64bit)

afaik x86-64 grew segments recently for 64 bit mode for an unnamed other
virtualization vendor


