Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTFPNLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 09:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFPNLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 09:11:25 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:4019 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263847AbTFPNLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 09:11:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16109.50492.555714.813028@gargle.gargle.HOWL>
Date: Mon, 16 Jun 2003 15:25:16 +0200
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org
Subject: 2.5.71 cardbus problem + possible solution
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.71 changed the name of the Yenta module from yenta_socket
to yenta. In my case (Latitude with RH9 user-space), this
prevented cardmgr from starting properly.

Quick fix: add 'alias yenta_socket yenta' to /etc/modprobe.conf,
or s/yenta_socket/yenta/ in the appropriate config file (but
then you make multi-booting 2.4/2.5 more difficult).

/Mikael
