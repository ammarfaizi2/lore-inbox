Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWFHM0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWFHM0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWFHM0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:26:25 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:35805 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751322AbWFHM0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:26:24 -0400
Date: Thu, 8 Jun 2006 14:25:56 +0200
From: Voluspa <lista1@comhem.se>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: adaptive readahead overheads
Message-Id: <20060608142556.2e10e379.lista1@comhem.se>
In-Reply-To: <349766648.27054@ustc.edu.cn>
References: <349406446.10828@ustc.edu.cn>
	<20060604020738.31f43cb0.akpm@osdl.org>
	<1149413103.3109.90.camel@laptopd505.fenrus.org>
	<20060605031720.0017ae5e.lista1@comhem.se>
	<349562623.17723@ustc.edu.cn>
	<20060608094356.5c1272cc.lista1@comhem.se>
	<349766648.27054@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 19:37:31 +0800 Fengguang Wu wrote:
> I'd like to show some numbers on the pure software overheads come with
> the adaptive readahead in daily operations.
[...]
> 
> # time find /usr -type f -exec md5sum {} \; >/dev/null
> 
> ARA
> 
> 406.00s user 325.16s system 97% cpu 12:28.17 total

Just out of interest, all your figures show an almost maxed out CPU.
Why is it that my own runs use so little CPU? I'm running the above
command as we 'speak' and on average only 40% is utilized, with the
occasional spike at max 75%. And this is on the lowest CPU level
800MHz, which means that the 80% up_threshold of the ondemand cpufreq
governor never is breached (there are 1800MHz, 2000MHz and 2200MHz
levels above it).

Are you only 'giving' qemu something like 400MHz to play with or is
qemu so inefficient in itself?

Mvh
Mats Johannesson
--
