Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTFTTgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTFTTgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 15:36:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43907 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264515AbTFTTgS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 15:36:18 -0400
Date: Fri, 20 Jun 2003 12:45:10 -0700 (PDT)
Message-Id: <20030620.124510.28800472.davem@redhat.com>
To: joern@wohnheim.fh-wedel.de
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au,
       dwmw2@infradead.org
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030620185915.GD28711@wohnheim.fh-wedel.de>
References: <20030620185915.GD28711@wohnheim.fh-wedel.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jörn Engel <joern@wohnheim.fh-wedel.de>
   Date: Fri, 20 Jun 2003 20:59:15 +0200
   
   The whole interface of the bzlib was modelled after the zlib
   interface.

The zlib interface is actually problematic, it doesn't allow
handling of scatter-gather lists on input or output for example.

Therefore we couldn't make the compress cryptolib interface
take scatterlists elements either, which is a huge problem.
