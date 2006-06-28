Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWF1Dkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWF1Dkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 23:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWF1Dkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 23:40:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19337 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751082AbWF1Dkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 23:40:45 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: cpu_up not called for boot cpu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Jun 2006 13:41:03 +1000
Message-ID: <8054.1151466063@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_up() is only called for secondary cpus, not for the boot cpu.  That
means that code hooked into the cpu_chain notifier never gets called
for the boot cpu, which prevents additional subsystems from taking
action for the boot cpu.  So how are additional subsystems meant to be
initialised for the boot cpu?

