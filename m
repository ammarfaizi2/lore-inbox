Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263809AbUD0GYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUD0GYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUD0GYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:24:33 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:60094 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263809AbUD0GYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:24:31 -0400
Subject: Largest mallocs opteron vs. 32bit systems
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083047064.3158.2.camel@localhost>
Mime-Version: 1.0
Date: Tue, 27 Apr 2004 08:24:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

I just did some tests trying to malloc() memory on an opteron and a xeon
system...

I wonder why I see regression for the opteron in 32bit mode. Comments
welcome (workarounds even more). Anyhow my observations:

malloc large block:

opteron -> up to 7G (64bit exe) -> up to 1500M (32bit exe)
xeon -> up to 2000M

malloc a couple of blocks of size 100M:

whole process (100 M steps)
opteron -> 7700M (64bit exe) -> up to 2200 (32bit exe)
xeon -> 2700M

So one 'looses' 500M.

Feedback welcome,
Soeren

