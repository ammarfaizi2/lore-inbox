Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWDYIYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWDYIYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWDYIYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:24:05 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:57883 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750994AbWDYIYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:24:02 -0400
Message-Id: <20060425082137.028875000@localhost.localdomain>
Date: Tue, 25 Apr 2006 16:21:37 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
Subject: [patch 0/2] kref debugging (retry)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enable to detect kref_put() with unreferenced object,
and split all kref debugging checks into new config debug option.

I can find many places where I can replace refcounter with kref by doing
"grep -r atomic_dec_and_test linux/".

If we have this detection of kref_put() with unreferenced object,
The work of kref convertions would be more than code cleanup and
consolidation.
--
