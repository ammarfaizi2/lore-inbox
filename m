Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264328AbUD0T64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbUD0T64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUD0T4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:56:15 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:40576 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S264310AbUD0Tzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:55:52 -0400
Date: Tue, 27 Apr 2004 20:54:09 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: Marc Boucher <marc@linuxant.com>
cc: Adam Jaskiewicz <ajjaskie@mtu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.44.0404272049290.5186-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Marc Boucher wrote:
> A lot of users don't read them though, so a proper fix remains 
> necessary..

Looking at some very very old scripts I wrote for clean loading binary 
modules I see some code to fix this:

dmesg -n 1
# do the module loading
dmesg -n 6

But, it assumes the syslog/klog is not running (well, you can temporarily
stop it) and also it starts minilogd temporarily and then kills it and
restarts syslog/klog.

Try it and see if it works for you. About 2-3 years ago it definitely 
worked :)

Kind regards
Tigran


