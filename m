Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932789AbWBUVQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWBUVQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWBUVQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:16:26 -0500
Received: from fnord.at ([217.160.110.113]:3592 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S932789AbWBUVQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:16:24 -0500
Date: Tue, 21 Feb 2006 22:16:23 +0100
From: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
To: linux-kernel@vger.kernel.org
Cc: rml@novell.com
Subject: [PATCH] procfs fixes for inotify/dnotify
Message-ID: <20060221211623.GA26413@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem description:
When a new process is created, the creation of the respective PID
subdirectory of /proc is deferred until the /proc-directory is beeing
read (by e.g. ps(1)). This causes file notification frameworks like
dnotify and inotify to not work correctly with /proc.

This patch fixes the problem.

Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
