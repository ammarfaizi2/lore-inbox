Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbTDOV3j (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTDOV3j 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:29:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44737
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264098AbTDOV3g (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:29:36 -0400
Subject: Re: Problem: 2.4.20, 2.5.66 have different IDE channel order
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304151436_MC3-1-3487-2162@compuserve.com>
References: <200304151436_MC3-1-3487-2162@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050439381.28591.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 21:43:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 19:33, Chuck Ebbert wrote:
>   Well, that matches what 2.4 does:
> 
> 
> 00:0d.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
> 00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
> 01:0b.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
> 
> 
>   2.5 nonmodular seems to be doing it in BIOS order  -- the HPT370 BIOS
> initializes before the Promise (and won't let it boot but I can deal
> with that.)  I'll probably replace it with a PDC20262 before looking

Im a bit puzzled by this because it does look like a bug. Our pci scan code hasnt changed
that materially. I assume the promise and hpt are both plug in cards >

