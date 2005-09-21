Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVIURWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVIURWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVIURWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:22:02 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:39331 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751166AbVIURWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:22:00 -0400
Message-ID: <433196B6.8000607@rtr.ca>
Date: Wed, 21 Sep 2005 13:21:58 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
Subject: Re: [RFC/BUG?] ide_cs's removable status
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain>
In-Reply-To: <1127321829.18840.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> I can't comment on the MMC layer or its core requirements as I don't
> know them well. IDE PCMCIA does however encompass removal devices. The
> removable flag is set so that we get removable media behaviour - that is
> the media can change under us and we must not cache partition data. The
> current behavioiur in that sense is correct.

Mmm.. I'm not so sure about that.

In the case of CF cards in ide-cs, removing the card is equivalent
to removing the entire IDE controller, not just the media.

So "media change" is not what happens here.

But yes, it still should be managed as a removable device,
but we currently seem to be using this bit to mean two things,
as explained by Russell in the given link.

 > http://lkml.org/lkml/2005/1/8/165

Cheers
