Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVIUSBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVIUSBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVIUSBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:01:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43956 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751221AbVIUSBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:01:14 -0400
Subject: Re: [RFC/BUG?] ide_cs's removable status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <liml@rtr.ca>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
In-Reply-To: <433196B6.8000607@rtr.ca>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Sep 2005 19:27:23 +0100
Message-Id: <1127327243.18840.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-21 at 13:21 -0400, Mark Lord wrote:
> In the case of CF cards in ide-cs, removing the card is equivalent
> to removing the entire IDE controller, not just the media.

It isn't the same as removing the entire PCMCIA controller layer. As far
as PCMCIA is concerned there has been no change. Thus we have no media
change event and we need ->removable = 1

If the PCMCIA card disappeared each time it would be different

