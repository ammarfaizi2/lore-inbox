Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRHAQx3>; Wed, 1 Aug 2001 12:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbRHAQxR>; Wed, 1 Aug 2001 12:53:17 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:60681 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267516AbRHAQxF>;
	Wed, 1 Aug 2001 12:53:05 -0400
Message-Id: <200107312246.CAA00465@mops.inr.ac.ru>
Subject: Re: Why istn't dup in TCP working??
To: nitin.dhingra@dcmtech.co.IN (Nitin Dhingra)
Date: Wed, 1 Aug 2001 02:46:56 -2000 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A01C6508E@dcmtechdom.dcmtech.co.in> from "Nitin Dhingra" at Jul 31, 1 01:15:00 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> module in 2.4.x the first error that I get is that dup is not a 
> part of socket's operation structure anymore. 
> 		So what is the replacement for it, I couldn't find any
> in the proto_ops structure?

dup was alias for sock_create() and hence deleted.

The question in reply: what did you use this for?
It was not used in 2.2 for anything but creating in accept()
a socket which was instanly dropped. :-)

Alexey
