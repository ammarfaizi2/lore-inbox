Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTBAScp>; Sat, 1 Feb 2003 13:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbTBAScp>; Sat, 1 Feb 2003 13:32:45 -0500
Received: from mailg.telia.com ([194.22.194.26]:5582 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S264945AbTBAScn>;
	Sat, 1 Feb 2003 13:32:43 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <005701c2ca21$9c1d90b0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
References: <004701c2ca03$cb467460$020120b0@jockeXP> <3E3C0684.4010806@pobox.com>
Subject: Re: NETIF_F_SG question
Date: Sat, 1 Feb 2003 19:42:01 +0100
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

> Joakim Tjernlund wrote:
> > I am thinking of implementing harware scatter/gatter support( NETIF_F_SG) in my 
> > ethernet driver. The network device cannot do HW checksuming.
> > 
> > Will the IP stack make use of the SG support and will there be any significant performance
> > improvement?
> 
> 
> No; you need HW checksumming for NETIF_F_SG to be useful.
> 
> If HW checksumming is not available, scatter-gather is useless, because 
> the net stack must always make a pass over the data to checksum it. 
> Since it must do that, it can linearize the skb at the same time, 
> eliminating the need for SG.
> 
> Jeff

linearize = copy small buffers inte one big buffer, or?
Surley the copy operation will cost something?   

 Jocke
