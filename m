Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUH2UCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUH2UCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUH2UCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:02:10 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29569 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268296AbUH2UCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:02:02 -0400
Subject: Re: libata dev_config call order wrong.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41321F7F.7050300@pobox.com>
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com>
	 <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com>
	 <41321F7F.7050300@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093805994.28289.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 19:59:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-29 at 19:25, Jeff Garzik wrote:
> According to the Serial ATA docs, IDENTIFY DEVICE word 93 will be zero 
> if it's Serial ATA.  Who knows if that's true, given the wierd wild 
> world of ATA devices.

You need to check if word 93 is valid first. Same with things like the
cache control word - its value is only meaningful if the drive says the
word is meaningful.

