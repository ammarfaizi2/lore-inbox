Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUJGSch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUJGSch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJGSas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:30:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:5839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267551AbUJGS3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:29:09 -0400
Date: Thu, 7 Oct 2004 11:25:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: mbligh@aracnet.com, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041007112531.674413f1.akpm@osdl.org>
In-Reply-To: <20041007105425.02e26dd8.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay>
	<20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
	<20041005190852.7b1fd5b5.pj@sgi.com>
	<1097103580.4907.84.camel@arrakis>
	<20041007015107.53d191d4.pj@sgi.com>
	<Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
	<1250810000.1097160595@[10.10.2.4]>
	<20041007105425.02e26dd8.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  3) you think that such a model can be provided sensibly from user space?

As you say, it's a matter of coordinated poking at cpus_allowed.  I'd be
interested to know why this all cannot be done by a userspace daemon/server
thing.
