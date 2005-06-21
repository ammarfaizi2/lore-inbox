Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFUMSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFUMSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVFUMRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:17:38 -0400
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:19175 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261431AbVFUMQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:16:08 -0400
Message-ID: <004c01c57662$5eacc260$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>, "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Domen Puncer" <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> <004001c5762e$d67ff390$2800000a@pc365dualp2> <200506211402.48554.vda@ilport.com.ua>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 09:08:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Memory is memory.  Pushed from the stack or as a 4 byte immediate value you
still have to get those 4 bytes somewhere  although with the pointer you DO
actually stand a chance GCC might enregister the pointer variable.

Sure you don't think instruction bytes fetching is free ;->

BTW, I don't give a shit about the size advantage.  Put the 3 byte EBP ref
and the 5 byte push imm32 in a loop and measure them - I know what the
answer will be.


----- Original Message ----- 
From: "Denis Vlasenko" <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>; "Jesper Juhl" <juhl-lkml@dif.dk>;
"linux-kernel" <linux-kernel@vger.kernel.org>
>
> But that 3 byte push is fetching data from stack, while 5 byte const push
> does not. I ike smaller code, but not _this_ much.
>
> Also this smallish size advantage may be i386-specific only.
> --
> vda
>

