Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbULOWt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbULOWt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbULOWt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:49:57 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:65496 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262523AbULOWtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:49:52 -0500
Message-ID: <14380712.1103150975468.JavaMail.tomcat@pne-ps3-sn1>
Date: Wed, 15 Dec 2004 23:49:35 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: mr@ramendik.ru
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier today I wrote:

>I find no problem when blender is the sole (large) application, but when a
>distributed computing client is running in the background the reported 
problems
>surface. I use http://folding.stanford.edu for protein folding. It runs
>with a default of nice 19 and sucks up every free CPU cycle. I've never
>seen it interfere with anything prior to this swap issue - been running
>it since 2000.

More testing done to find the breaking point. Running the folding client and 
blender:

2.6.8.1-bk2 is the last kernel without _any_ swapping problem (no screen freezes 
etc)
|
| 2.6.9-rc1 and three -bk forward have oopses and loss of keyboard in X. 
Can't test them.
|
2.6.9-rc1-bk4 is the first functional kernel where the freezes show up.

So it is a real regression.

Mvh
Mats Johannesson

