Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVIRSXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVIRSXv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 14:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVIRSXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 14:23:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33378
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932159AbVIRSXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 14:23:50 -0400
Date: Sun, 18 Sep 2005 20:24:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: oom_score script
Message-ID: <20050918182434.GI4122@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I sometime use this script to tune the oom_adj on some server, so I
thought it would be good idea to share it. First column is the pid,
second is the oom_score, third is the executable name.

Thanks.

#!/bin/sh

# (C) SUSE, GPL'd

ls /proc/*/oom_score| grep -v self | sed 's/\(.*\)\/\(.*\)/echo -n "\1 "; echo -n "`cat \1\/\2 2>\/dev\/null` "; readlink \1\/exe || echo/'|sh |sort -nr +1
