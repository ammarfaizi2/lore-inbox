Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWHGP6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWHGP6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHGP6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:58:15 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:44224 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750799AbWHGP6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:58:14 -0400
Date: Mon, 7 Aug 2006 11:57:55 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Sam Ravnborg <sam@mars.ravnborg.org>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3-mm2, lxdialog, and O=
Message-ID: <20060807155755.GA4556@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O= builds are broken, with the following error:

fatal error: opening dependency file
scripts/kconfig/lxdialog/.checklist.o.d: No such file or directory

git-lxdialog.patch appears to be the offender.  Backing it out fixes
this problem.  It's a large patch, so I didn't try to pull it apart to
figure out where exactly the problem was.

				Jeff
