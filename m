Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUH0LSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUH0LSB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 07:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUH0LSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 07:18:01 -0400
Received: from [139.30.44.16] ([139.30.44.16]:14300 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263769AbUH0LR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 07:17:57 -0400
Date: Fri, 27 Aug 2004 13:17:41 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Gergely Tamas <dice@mfa.kfki.hu>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: data loss in 2.6.9-rc1-mm1
In-Reply-To: <20040827105543.GA10563@mfa.kfki.hu>
Message-ID: <Pine.LNX.4.53.0408271313200.9045@gockel.physik3.uni-rostock.de>
References: <20040827105543.GA10563@mfa.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> $ uname -r
> 2.6.9-rc1-mm1
> 
> $ dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
> 10+0 records in
> 10+0 records out
> 10485760 bytes transferred in 0.028418 seconds (368981986 bytes/sec)
> 
> $ du -sb testfile
> 10485760        testfile
> 
> $ cat testfile > testfile.1
> 
> $ du -sb testfile.1
> 10481664        testfile.1


What does ls -l testfile.1 give?
What you describe actually can be correct behaviour, since the file is
all zeros.

Although yes, it seems highly improbable someone implemented an 
optimization that cuts away just one of 2560 pages.

Tim
