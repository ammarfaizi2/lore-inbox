Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTJ3Vbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTJ3Vbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:31:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:52910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262865AbTJ3Vbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:31:33 -0500
Date: Thu, 30 Oct 2003 13:33:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Message-Id: <20031030133316.6bd00b4a.akpm@osdl.org>
In-Reply-To: <200310301601.55588.schlicht@uni-mannheim.de>
References: <200310301601.55588.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
>  today I tried to test TCQ with the linux-2.6.0-test9-mm1 kernel. The config.gz 
>  is attached. But after enabling TCQ with 'hdparm -Q1 /dev/hda' newly started 
>  processes die due to a received SIGSEGV. No bad kernel messages appear...

Probably we need to turn off TCQ in kernel config until the confidence
level is higher.

>  Disabling TCQ again doesn't help, only e reboot does...

That will be because you have incorrect program text in pagecache, left
over from when the driver was in TCQ mode.

