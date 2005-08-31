Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVHaLDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVHaLDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVHaLDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:03:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50106 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932311AbVHaLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:03:33 -0400
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Thomas Renninger <trenn@suse.de>
In-Reply-To: <20050831103402.GA6496@atomide.com>
References: <1125354385.4598.79.camel@mindpipe>
	 <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com>
	 <200508301701.49228.s0348365@sms.ed.ac.uk>
	 <20050831074419.GA1029@atomide.com>
	 <1125477566.3213.6.camel@laptopd505.fenrus.org>
	 <20050831103402.GA6496@atomide.com>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 13:03:05 +0200
Message-Id: <1125486186.3213.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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


> > ehh
> > why does it cause slow boots?
> > if that kind of behavior changes... isn't that a sign there is a
> > fundamental bug still ?
>  
> Well it seems like the next_timer_interrupt is something like 400
> jiffies away and RCU code waits for completion for example in the
> network code.

that sounds like a fundamental issue that really needs to be fixed
first!


