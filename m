Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWH1RkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWH1RkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWH1RkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:40:10 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:12458 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751109AbWH1RkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:40:07 -0400
Message-ID: <004401c6cac8$85991570$0d71908d@ralph>
From: "Chuck Lever" <chuck.lever@oracle.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Adrian Bunk" <bunk@stusta.de>,
       "Trond Myklebust" <Trond.Myklebust@netapp.com>,
       <linux-kernel@vger.kernel.org>
References: <20060826160922.3324a707.akpm@osdl.org><20060826235628.GL4765@stusta.de><000601c6ca06$28b62cc0$b461908d@ralph> <20060827135654.27e29ee4.akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3: ROOT_NFS=y compile error
Date: Mon, 28 Aug 2006 13:36:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Adrian Bunk" <bunk@stusta.de>; "Trond Myklebust" 
<Trond.Myklebust@netapp.com>; <linux-kernel@vger.kernel.org>
Sent: Sunday, August 27, 2006 4:56 PM
Subject: Re: 2.6.18-rc4-mm3: ROOT_NFS=y compile error

>>  All my copies of this patch
>> series has this change, but Andrew's doesn't.
>
> What is "this change"?  The only change I see in Trond's mount_clnt.c is 
> the
> removal of the xprt.h include.

Found the problem.  Because of changes Trond had included already in his 
tree, my patches didn't fit on his repository.  When I ported my patches to 
his tree, I accidentally left out the hunk that updates fs/nfs/mount_clnt.c.

Trond should be sending out the missing hunk soon. 

