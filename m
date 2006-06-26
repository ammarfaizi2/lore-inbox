Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWFZQix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWFZQix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFZQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:38:53 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43500 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750784AbWFZQiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:38:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:38:50 +1000
Subject: [Suspend2][ 0/2] Freezer Upgrade
Message-Id: <20060626163850.10345.13807.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patches to upgrade the freezer and disable the updating of the
load average while we're suspended. The former is primarily
quieting debugging information, adding support for thawing
kernel threads without thawing userspace and freezing bdevs.
The later is needed because suspending is very cpu intensive,
and the load average will be high post-resume if we don't do
this. Having a high load average will in turn cause some
processes such as mtas to delay their work until the number
drops.
