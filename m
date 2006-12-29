Return-Path: <linux-kernel-owner+w=401wt.eu-S1753961AbWL2BOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbWL2BOV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 20:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbWL2BOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 20:14:21 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:38385 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753961AbWL2BOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 20:14:21 -0500
Message-ID: <45946BF2.8030501@lwfinger.net>
Date: Thu, 28 Dec 2006 19:14:26 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: build anomaly in 2.6.20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.20-rc2, fs/proc/proc_misc.c has been changed to need include/linux/compile.h. As the latter
file contains the dat and time of the compilation, this change ensures that the kernel will be
relinked with every make call, even if it is run just after a successful make run.

In my work as the bcm43xx maintainer, I make frequent trial changes to that module. It seems a waste
to have to relink the kernel with every such change.

Larry
