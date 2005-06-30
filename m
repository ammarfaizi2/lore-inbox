Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVF3IqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVF3IqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbVF3IqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:46:05 -0400
Received: from mail-1.netbauds.net ([62.232.161.102]:43466 "EHLO
	mail-1.netbauds.net") by vger.kernel.org with ESMTP id S262888AbVF3Ipy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:45:54 -0400
Message-ID: <42C3B11B.80909@netbauds.net>
Date: Thu, 30 Jun 2005 09:45:15 +0100
From: "Darryl L. Miles" <darryl@netbauds.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Christian Trefzer <ctrefzer@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org> <42BE7E38.9070703@netbauds.net> <42BE98C5.1070102@web.de> <20050626141106.GA12223@shuttle.vanvergehaald.nl> <42BF92D4.3040609@netbauds.net> <42C33149.3090305@web.de>
In-Reply-To: <42C33149.3090305@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The exact patch for kernel/module.c that was marked for 2.6.11-rcX hit 
general release in patch-2.6.12.

What $PID is bash running as ?  Martin's comments on this are seem most 
relevant.

Can you build your own (2 pages of code) init process, that does 
something along the lines of
 * gracefully handles SIGCHLD
 * forks
 * executes bash
 * waits for bash to exit much like the patch does

So bash is not running a pid 1.  While nash is expected to run as init, 
bash is not, so fixing bash might also break it (its a complex beast).

-- 
Darryl L. Miles


