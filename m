Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbULSX6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbULSX6T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 18:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbULSX6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 18:58:19 -0500
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:48399 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S261353AbULSX6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 18:58:16 -0500
Date: Sun, 19 Dec 2004 15:57:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       kernel@kolivas.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Message-Id: <20041219155722.01b1bec0.akpm@digeo.com>
In-Reply-To: <41C6073B.6030204@yahoo.com.au>
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
	<41C6073B.6030204@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2004 23:57:55.0191 (UTC) FILETIME=[8EC92870:01C4E626]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew, what should we do?

- Ask Voluspa to do

	echo 0 > /proc/sys/vm/swap_token_timeout

  on 2.6.10-rc3 and retest.

- Dig out Rik's token-timeout-autotuning patch, make it apply, test it,
  then ask Volupsa and others to test that.

Have you time to look into the latter?

(We still don't know why it chews tons of CPU, do we?)
