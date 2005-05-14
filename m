Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVENIck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVENIck (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 04:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVENIck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 04:32:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9856 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262660AbVENIcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 04:32:39 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Arjan van de Ven <arjan@infradead.org>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050513225135.20005.qmail@science.horizon.com>
References: <20050513225135.20005.qmail@science.horizon.com>
Content-Type: text/plain
Date: Sat, 14 May 2005 10:03:39 +0200
Message-Id: <1116057819.6007.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 22:51 +0000, linux@horizon.com wrote:
> If RDTSC is too annoying to disable, just interpret the same flag as a
> "schedule me solo" flag that prevents scheduling anything else (at least,
> not sharing the same ->mm) on the other virtual processor.  (Of course,
> the time should count double for scheduler fairness purposes.)

rdtsc is so unreliable on current hardware that no userspace app should
be using it anyway; it's not synchronized on SMP, powermanagement
impacts the rate of the ticks all the time etc etc.
Basically it's worthless on modern machines for anything but in-kernel
busy loops.


