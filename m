Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268192AbUHFRcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268192AbUHFRcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUHFRbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:31:31 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:57729 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S268192AbUHFRZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:25:16 -0400
Date: Fri, 6 Aug 2004 18:24:58 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
In-Reply-To: <Pine.LNX.4.60.0408061742300.2622@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.60.0408061814150.2622@fogarty.jakma.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
 <1091795565.16307.14.camel@localhost.localdomain> <4113A684.8050302@pobox.com>
 <Pine.LNX.4.60.0408061742300.2622@fogarty.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Paul Jakma wrote:

> ie, is possible to avoid a reboot?

Hmmm, Jeff, the sector number in the error message is correct right:

end_request: I/O error, dev sda, sector 3393536

I can test that sector, destructively if needs be (its been kicked 
from raid array) - which is likely to work if the drive still has 
spare blocks and it's genuinely a media error, it can remap on write.

If i get same error trying to read that sector again and again it's a 
drive problem, right? The following command run a few times should 
trigger the same errors if its the drive, right?

 	dd seek=3393535 bs=1b count=2 if=/dev/sda3 of=/dev/null

ah, just tried it, it doesnt.. hmm.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
My doctor told me to stop having intimate dinners for four.  Unless there
are three other people.
 		-- Orson Welles
