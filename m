Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUFRPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUFRPZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUFRPXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:23:21 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:29312 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S265266AbUFRPWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:22:08 -0400
From: Andrew Walrond <andrew@walrond.org>
To: netfilter@lists.netfilter.org
Subject: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
Date: Fri, 18 Jun 2004 16:11:37 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406181611.37890.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "cenedra.walrond.org", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  The addition of a __user attribute to a line in
	linux-2.6.7/include/linux/netfilter_ipv4/ip_tables.h causes iptables
	build to fail unless I export CC="gcc -D__user= " Presumably
	ip_tables.h should include a header defining __user, or iptables should
	include the relevant header before ip_tables.h ? [...] 
	Content analysis details:   (0.0 points, 7.5 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of a
	__user
attribute to a line in
	linux-2.6.7/include/linux/netfilter_ipv4/ip_tables.h
causes iptables build to fail unless I export
	CC="gcc -D__user= "

Presumably ip_tables.h should include a header defining __user, or iptables 
should include the relevant header before ip_tables.h ?

Sorry if this has already been reported; Archive search found nothing on 
either ML.

Andrew Walrond
