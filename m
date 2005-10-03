Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVJCPcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVJCPcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVJCPcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:32:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47247 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932301AbVJCPcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:32:04 -0400
Subject: Re: [PATCH] RCU torture testing
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
In-Reply-To: <20051003152602.GD1300@us.ibm.com>
References: <20051001182056.GA1613@us.ibm.com>
	 <20051002210549.GA8503@elf.ucw.cz> <20051003143009.GB1300@us.ibm.com>
	 <1128350188.17024.14.camel@laptopd505.fenrus.org>
	 <20051003152602.GD1300@us.ibm.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 17:31:59 +0200
Message-Id: <1128353520.17024.19.camel@laptopd505.fenrus.org>
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


> Good point -- all I really need for module parameters is the number
> of readers.  I should be able to have module load start the test and
> module unload stop it (any problems with this approach?). 

only one potential gotcha; it means you can't load the system to the
extend that the shell doesn't get cpu time otherwise the admin can never
issue the unload. Maybe a time limit on the testing? (optional as module
parm for all I care)

