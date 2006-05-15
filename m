Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWEORLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWEORLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWEORLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:11:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61858 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964990AbWEORLB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:11:01 -0400
Subject: Re: how to set this in the future
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen.Clark@seclark.us
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4468B3E5.5090209@seclark.us>
References: <4466437C.1070306@seclark.us>
	 <1147702848.26686.29.camel@localhost.localdomain>
	 <4468B3E5.5090209@seclark.us>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 18:23:42 +0100
Message-Id: <1147713822.26686.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 13:01 -0400, Stephen Clark wrote:
> I have a hp pavilion laptop n5430 with an ali chipset. I have a hitachi 
> drive that will do udma100 - the docs on my laptop say it will do udma4 
> but linux by default is setting it to
> udma2.

Sounds like the laptop vendor has used short 40 wire cable instead of 80
wire internally to the laptop. This is valid but requires special
knowledge in the driver of those devices who do it.

> 00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if 8a 

Can you give me an lspci -vvxxx of that device (or from the box), and
also the output of "dmidecode". That way I can automate the detection in
the new libata pata_ali driver, and if you cc Bartlomiej he can add it
to the old driver (B.Zolnierkiewicz@elka.pw.edu.pl)

Alan
