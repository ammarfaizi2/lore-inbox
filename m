Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132879AbRDQVt5>; Tue, 17 Apr 2001 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132884AbRDQVts>; Tue, 17 Apr 2001 17:49:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14610 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132879AbRDQVtf>; Tue, 17 Apr 2001 17:49:35 -0400
Subject: Re: kernel threads and close method in a device driver
To: mleisner@eng.mc.xerox.com (Marty Leisner)
Date: Tue, 17 Apr 2001 22:37:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, leisner@rochester.rr.com
In-Reply-To: <200104172104.RAA08013@mailhost.eng.mc.xerox.com> from "Marty Leisner" at Apr 17, 2001 05:04:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pdAR-0003Kc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What can cause a close not to get invoked?  BTW, the close is returning
> with a 0 status to the application ...(it definitely did NOT 
> get invoked in the driver)

The driver release function is invoked when the use count of the handle hits
zero. Make sure you are not muddling release and flush ?
