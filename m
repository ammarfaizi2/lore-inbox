Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTBAWHh>; Sat, 1 Feb 2003 17:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTBAWHg>; Sat, 1 Feb 2003 17:07:36 -0500
Received: from mailf.telia.com ([194.22.194.25]:4814 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S265037AbTBAWHg>;
	Sat, 1 Feb 2003 17:07:36 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <006f01c2ca3f$9b691220$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <romieu@fr.zoreil.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
References: <004701c2ca03$cb467460$020120b0@jockeXP> <3E3C0684.4010806@pobox.com> <005701c2ca21$9c1d90b0$020120b0@jockeXP> <20030201201627.A25670@electric-eye.fr.zoreil.com>
Subject: Re: NETIF_F_SG question
Date: Sat, 1 Feb 2003 23:16:45 +0100
Organization: Lumentis AB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Joakim Tjernlund <Joakim.Tjernlund@lumentis.se> :
> [...]
> > Surley the copy operation will cost something?   
> 
> Cost is hidden while checksumming.
> 
> --
> Ueimor

Yes, I realize that you can make the cost much smaller by checksumming and
copying at the same time. However for every word that is checksummed one must 
execute an extra store. That store will also hit the L1 cache, flushing more
important data to memory, so maybe the cost is visible?

 Jocke 
