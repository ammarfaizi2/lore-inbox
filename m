Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbVLGRzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVLGRzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbVLGRzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:55:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751478AbVLGRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:55:35 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <1133977623.24344.31.camel@localhost>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 18:55:27 +0100
Message-Id: <1133978128.2869.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Many of the interesting places that deal with pids and where you
> > want translation are not where the values are read from current->pid,
> > but where the values are passed between functions.  Think about
> > the return value of do_fork.
> 
> Exactly.  The next phase will focus on such places.  Hubertus has some
> stuff working that's probably not ready for LKML, but could certainly be
> shared.
> 

hmm wonder if it's not just a lot simpler to introduce a split in
"kernel pid" and "userspace pid", and have current->pid and
current->user_pid for that.

Using accessor macros doesn't sound like it gains much here.. (but then
I've not seen the full picture and you have)

