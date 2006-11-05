Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965864AbWKEMdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965864AbWKEMdL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 07:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965866AbWKEMdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 07:33:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37513 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965864AbWKEMdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 07:33:09 -0500
Subject: Re: New filesystem for Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brad Campbell <brad@wasp.net.au>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <454DCAAC.3080903@wasp.net.au>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
	 <1162691856.21654.61.camel@localhost.localdomain>
	 <454DC799.9000401@superbug.co.uk>  <454DCAAC.3080903@wasp.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 12:37:24 +0000
Message-Id: <1162730244.31873.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-11-05 am 15:27 +0400, ysgrifennodd Brad Campbell:
> I've never seen this behaviour in a drive. All the drives I've seen mark bad sectors as "pending 
> reallocation", they they return read errors on that sector unless they manage to jag a good read, in 
> which case they then reallocate the sector. Or else they wait for you to write to the sector 
> triggering a reallocation.

If a drive finds a sector has a high amount of error but readable it can
certainly relocate it and I'd hope it does it atomically as a
transaction. You wouldn't see it as unlike SCSI the ATA world doesn't
have an "I got your sector and did a rewrite" return code
