Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUA1XcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUA1XcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:32:21 -0500
Received: from post.tau.ac.il ([132.66.16.11]:26784 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S266173AbUA1XcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:32:20 -0500
Date: Thu, 29 Jan 2004 01:30:39 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: (2.4) ext3 - commit=NNN overridden by laptopmode (bdflush)
Message-ID: <20040128233039.GG3975@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.51; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When looking into the ext3 commit code I saw that it has a commit=NNN
mount option for specifying the log update time (same as in 2.6). The
problem is that this value is overridden by the laptopmode code that
was added which uses the value of get_buffer_flushtime which takes its
value from bdflush, which makes that option obsolete.
It looks to me that the bdflush code should be taken back out of the
ext3 code.
I don't mind doing it but only if there is interest. 
