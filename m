Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263195AbUJ2KDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbUJ2KDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbUJ2KDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:03:37 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:64167 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263195AbUJ2KCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:02:51 -0400
Subject: [RFC][PATCH 0/3] net: generic netdev_ioaddr
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: davem@davemloft.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Date: Fri, 29 Oct 2004 13:04:04 +0300
Message-Id: <1099044244.9566.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch introduces a generic netdev_ioaddr and converts natsemi and
8139too drivers to use it.

With the recent __iomem annotations, the network drivers need to either
invent this wrapper (like natsemi has done) or duplicate the IO base
address in their private data (similar to 8139too).  Therefore, lets
make netdev_ioaddr generic before it is all over the place.

			Pekka

