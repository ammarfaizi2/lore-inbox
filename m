Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbUKJIuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbUKJIuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKJIuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:50:21 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:5590 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S261549AbUKJIuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:50:06 -0500
Subject: Re: [Lse-tech] Re: [PATCH 2.6.9 0/2] new enhanced accounting data
	collection
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Reply-To: guillaume.thouvenin@bull.net
To: Jay Lan <jlan@engr.sgi.com>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
In-Reply-To: <41916ECB.4070102@engr.sgi.com>
References: <418FC082.8090706@engr.sgi.com>
	 <1100007698.18813.12.camel@frecb000711.frec.bull.fr>
	 <41916ECB.4070102@engr.sgi.com>
Message-Id: <1100076554.18813.28.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 10 Nov 2004 09:49:15 +0100
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2004 09:56:06,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2004 09:56:10,
	Serialize complete at 10/11/2004 09:56:10
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 02:28, Jay Lan wrote:
> I looked at the latest 2.6.10-rc1-mm4, and found the eop handler
> acct_process(code) used to be invoked per process from do_exit()
> has been hijacked :) to become a per group thing. I would still like
> to have a per process eop handling. How about BSD and ELSA?

ELSA uses a daemon called "jobd" which is able to produce a file that
contains informations about the relationship between a process and its
job. The conjunction of this file and the per-job accounting information
(currently the BSD-accounting) allows ELSA to provide per-job
accounting. Thus, I also need per-process accounting. Maybe the per
process eop handling can be done with CSA...

Guillaume 

