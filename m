Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTJ0DmS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 22:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTJ0DmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 22:42:18 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:49353 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263745AbTJ0DmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 22:42:17 -0500
Date: Mon, 27 Oct 2003 04:42:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: CONFIG_IP_NF_IPTABLES=m breaks 2.6 BK compile
Message-ID: <20031027034214.GA26161@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there is a configuration problem in the current BK kernel. With
CONFIG_IP_NF_IPTABLES=m, I'm getting these errors:

net/built-in.o(.init.text+0x248e): In function `init':
: undefined reference to `ipt_register_match'
net/built-in.o(.exit.text+0x1ae): In function `fini':
: undefined reference to `ipt_unregister_match'

These go away with CONFIG_IP_NF_IPTABLES=y.

.config file at
http://mandree.home.pages.de/linux-2.6-BK-config
(MD5 hash is 5e32c5b9305943587f977711cf8a8c66)

BK checked out a moment ago, 1.1359 is the rightmost entry in bk
histtool. Parent repository is bk://linux.bkbits.net/linux-2.5/

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
