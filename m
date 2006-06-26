Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWFZQqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWFZQqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWFZQqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:46:36 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30693 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750808AbWFZQqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:46:33 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:46:37 +1000
Subject: [Suspend2][ 0/4] Files shared with swsusp.
Message-Id: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modifications to files shared with swsusp. We implement
CONFIG_SUSPEND_SHARED, which is selected by either swsusp
or Suspend2 and causes the parts required by either
implementation to be compiled in. Swsusp's kernel/power
files are compiled in after Suspend2's because Suspend2
recognises swsusp files and ignores them, but swsusp doesn't
recognise Suspend2 signatures and complains about them.
