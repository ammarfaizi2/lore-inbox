Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWEMPbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWEMPbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWEMPbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:31:49 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:59627 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751324AbWEMPbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:31:49 -0400
Subject: Re: [Sdhci-devel] sdhci needs card to be present when loading
	module.
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: drzeus-sdhci@drzeus.cx, linux-kernel@vger.kernel.org,
       sdhci-devel@list.drzeus.cx
In-Reply-To: <20060512232940.GA30610@kroah.com>
References: <20060512232940.GA30610@kroah.com>
Content-Type: text/plain
Date: Sat, 13 May 2006 17:33:07 +0200
Message-Id: <1147534387.19948.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> In the 2.6.17-rc4 kernel (and 2.6.17-rc1), on my laptop, if you load the
> sdhci driver with no SD card in the slot, it never seems to be able to
> detect the insertion of a new card later on.
> 
> However, if I load the module with a card present.  Removing it and then
> plugging it (or another one) in later seems to work just fine.

I had the same problem with my Ricoh controller (in an IBM X41) and the
latest sdhci driver from mainline. Try the audit patch from Pierre, but
be careful. For me it freezes the machine on eject, because of an
endless loop waiting for some hardware state to change.

Regards

Marcel


