Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVLAMlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVLAMlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVLAMlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:41:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6529 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932193AbVLAMlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:41:16 -0500
Subject: Re: loadavg always equal or above 1.00 - how to explain?
From: Arjan van de Ven <arjan@infradead.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <438EE515.1080001@wpkg.org>
References: <438EE515.1080001@wpkg.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 13:41:11 +0100
Message-Id: <1133440871.2853.36.camel@laptopd505.fenrus.org>
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

On Thu, 2005-12-01 at 12:57 +0100, Tomasz Chmielewski wrote:
> 
> 1.00 1.10 1.06 1/65 782
> 
> This server is barely used, and as I remember, loadavg was always
> close 
> to 0.00 on that system.

remember that load is the sum of running/runable processes and processes
in D state (waiting for IO generally, but not always). I'm pretty sure
your load comes from one of the later...

ps ought to tell you which one it is... (if not, an 
"echo t > /proc/sysrq-trigger" will dump the kernel state including the
offending process, and will also tell us where exactly that process is)

Greetings,
    Arjan van de Ven

