Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbTFLWBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbTFLWBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:01:34 -0400
Received: from mail.webmaster.com ([216.152.64.131]:10473 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265019AbTFLWB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:01:29 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Muthian Sivathanu" <muthian_s@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: limit resident memory size
Date: Thu, 12 Jun 2003 15:15:13 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEBMDKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030612205557.5874.qmail@web40602.mail.yahoo.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would like to limit the maximum resident memory size
> of a process within a threshold, i.e. if its virtual
> memory footprint exceeds this threshold, it needs to
> swap out pages *only* from within its VM space.

	Why? If you think this is a good way to be nice to other processes, you're
wrong.

> First, is there a way this can be done at application
> level ? The setrlimit interface seems to contain an
> option for specifying max resident set size, but it
> doesnt seem like it is implemented as of 2.4 -- am I
> wrong ?

> If the kernel doesnt currently support it, is there an
> efficient way (data structure etc) to traverse the
> resident set of a *process* in lru fashion ?  All the
> page replacement and swapping code work on the entire
> page lists -- is there any simple way to group these
> per process ?

	One process paging and swapping excessively will hurt other processes that
aren't. What's your outer problem? What you're trying to do doesn't seem to
have any rational purpose.

	DS


