Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136498AbREIOa2>; Wed, 9 May 2001 10:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136496AbREIOaT>; Wed, 9 May 2001 10:30:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18442 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136498AbREIOaK>; Wed, 9 May 2001 10:30:10 -0400
Subject: Re: How to compile kernel for Geode GX1
To: jordanc@Censoft.com
Date: Wed, 9 May 2001 15:33:16 +0100 (BST)
Cc: jma@netgem.com (Jocelyn Mayer), antonpoon@hongkong.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <01050908094005.28749@cosmic> from "Jordan Crouse" at May 09, 2001 08:09:40 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xV1i-0002Sv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you are using the vesa framebuffer on the Geode, you will also want to 
> make a minor change to vesafb.c.  Because the framebuffer is located within 
> the processor itself, requesting the memory region always caused my Geode 
> boxes to freeze.  I think that we can safely eliminate this call, since we 
> know the memory is always available:  

That actually looks like a correct change. The Geode and one or two other
devices use memory that may well not be visible in the system map. Being
unable to map the memory in the vesafb case is worth a warning but not
fatal
