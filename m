Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSHAPf3>; Thu, 1 Aug 2002 11:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSHAPf3>; Thu, 1 Aug 2002 11:35:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10992 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315458AbSHAPf2>; Thu, 1 Aug 2002 11:35:28 -0400
Subject: Re: [patch] vm86: Clear AC on INT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Kasper Dupont <kasperd@daimi.au.dk>, stas.orel@mailcity.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 17:52:30 +0100
Message-Id: <1028220750.15022.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 16:15, Richard B. Johnson wrote:
> Alignment-check does not exist in real mode. Therefore AC flags
> mean nothing. In fact, you can't even access more than 16 bits
> of the flags register in real mode, even by playing tricks
> (pushf pushes only 16 bits, even if you prefix it with 0x66).

The kernel using virtual 8086 mode, not real mode. In Virtual 8086 mode
the alignment trap is enforced and honoured.

