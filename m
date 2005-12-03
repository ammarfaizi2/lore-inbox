Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVLCXuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVLCXuF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVLCXuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:50:05 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:20627 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932176AbVLCXuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:50:04 -0500
From: David Brownell <david-b@pacbell.net>
To: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
Date: Sat, 3 Dec 2005 15:50:01 -0800
User-Agent: KMail/1.7.1
Cc: vitalhome@rbcmail.ru, linux-kernel@vger.kernel.org, dpervushin@gmail.com,
       akpm@osdl.org, komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051203171037.94369.qmail@web36914.mail.mud.yahoo.com>
In-Reply-To: <20051203171037.94369.qmail@web36914.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512031550.01695.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 9:10 am, Mark Underwood wrote:
> 
> David, how would you feel about adding a NOT_DMAABLE flag in the spi_message structure?

Not good; it'd mean that every controller driver would have to support
both PIO and DMA modes.  This minor issue (despite the noise!) isn't
worth making such an intrusive demand on all drivers.


> The other solution is to do a kmalloc for each caller (would could try to be smart and only do
> that if the buffer is being used). 

That's far preferable.  You could just submit the patch against rc3-mm1
and that'll do the job.

- Dave

