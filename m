Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWJAQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWJAQgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWJAQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:36:04 -0400
Received: from havoc.gtf.org ([69.61.125.42]:26093 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750990AbWJAQgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:36:01 -0400
Date: Sun, 1 Oct 2006 12:35:59 -0400
From: Jeff Garzik <jeff@garzik.org>
To: pc300@cyclades.com, khc@pm.waw.pl, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: wan/pc300 bug found
Message-ID: <20061001163559.GA8649@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following gcc warning indicates a bug:

drivers/net/wan/pc300_drv.c: In function ‘cpc_open’:
drivers/net/wan/pc300_drv.c:2870: warning: ‘br’ may be used uninitialized in this function

clock_rate_calc() is not checked for a negative return value.

