Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWGQWLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWGQWLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGQWLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:11:54 -0400
Received: from 72-26-225-114.meganetserve.net ([72.26.225.114]:18361 "EHLO
	sv1.vipserv.org") by vger.kernel.org with ESMTP id S1751206AbWGQWLx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:11:53 -0400
Message-ID: <001601c6a9ee$00b21820$0100000a@katana>
From: "naox" <naox@yum.pl>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM (bug?) with ulimit -n
Date: Tue, 18 Jul 2006 00:11:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sv1.vipserv.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - yum.pl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so far I've been using kernels 2.4.32. I've upgraded to 2.6.17.1 and I've 
noticed a something not right. TCP connection arent closed when user is over 
his limit for open connections (ulimit -n). In my previous kernel 
connections was new imedietly closed is user were above limit. Now however 
connectios are kept open until client site timeouts - so it might be forever 
open. 

