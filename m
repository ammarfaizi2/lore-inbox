Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUCaQBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUCaQBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:01:36 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:25266 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262031AbUCaQBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:01:30 -0500
To: linux-kernel@vger.kernel.org
Subject: NFS ENOLCK problem with CONFIG_SECURITY=n
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 31 Mar 2004 08:01:29 -0800
Message-ID: <527jx1atuu.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Mar 2004 16:01:29.0102 (UTC) FILETIME=[6D81E2E0:01C41739]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with lockf returning ENOLCK on an NFS directory.
I also see messages like

    nsm_mon_unmon: rpc failed, status=-13
    lockd: cannot monitor 10.0.0.5
    lockd: failed to monitor 10.0.0.5

The system is an IA64 system running Debian testing with kernel 2.6.4.
I found previous reports of a similar problem, but the solution was to
set CONFIG_SECURITY to n (or add CONFIG_SECURITY_CAPABILITIES).
However, I already have CONFIG_SECURITY off:

    $ zgrep CONFIG_SECURITY /proc/config.gz
    # CONFIG_SECURITY is not set

Am I missing something?

Thanks,
  Roland
