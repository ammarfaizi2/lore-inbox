Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVAOUVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVAOUVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 15:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVAOUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 15:21:17 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27401 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262316AbVAOUVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 15:21:14 -0500
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       matthias@corelatus.se, linux-kernel@vger.kernel.org
In-Reply-To: <20050115195504.GA10754@taniwha.stupidest.org>
References: <16872.55357.771948.196757@antilipe.corelatus.se>
	 <20050115013013.1b3af366.akpm@osdl.org>
	 <20050115093657.GI3474@holomorphy.com>
	 <1105783125.6300.32.camel@laptopd505.fenrus.org>
	 <20050115195504.GA10754@taniwha.stupidest.org>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 21:20:59 +0100
Message-Id: <1105820460.6300.86.camel@laptopd505.fenrus.org>
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

On Sat, 2005-01-15 at 11:55 -0800, Chris Wedgwood wrote:
> On Sat, Jan 15, 2005 at 10:58:45AM +0100, Arjan van de Ven wrote:
> 
> > I don't see a valid reason to restrict/reject input that is accepted
> > now and dealt with reasonably because some standard says so (if you
> > design a new api, following the standard is nice of course). I don't
> > see "doesn't reject a condition that can reasonable be dealt with"
> > as a good reason to go double ABI at all.
> 
> we could printk for now and if nobody reports this to lkml (as they
> do/did with oldish tcpdump/libpcap a while ago) we could -EINVAL
> 

but why????

if someone wants the stuff rejected in a posix confirm way, he can do
these tests easily in the syscall wrapper he needs anyway for this
function.


