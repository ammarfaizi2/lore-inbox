Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271187AbTHRCTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 22:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHRCTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 22:19:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:9154 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271187AbTHRCTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 22:19:42 -0400
Date: Sun, 17 Aug 2003 19:21:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Foerster <stefan@stefan-foerster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
Message-Id: <20030817192103.798994d8.akpm@osdl.org>
In-Reply-To: <20030818013243.GB21665@in-ws-001.cid-net.de>
References: <20030818013243.GB21665@in-ws-001.cid-net.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Foerster <stefan@stefan-foerster.de> wrote:
>
> But as soon as I do a
> 
>  while true; do dd if=/dev/zero of=test bs=1024 count=1048576 ; rm test
>  ; done
> 
>  on my SCSI disk, the system becomes completely unusuable after a few
>  seconds.

I've been running an aic7xx-based desktop on 2.5/2.6 for ages, no
such problems.

A kernel profile would be needed to diagnose this.  You could use
readprofile, but as it may be an interrupt problem, the NMI-based oprofile
output would be better.


