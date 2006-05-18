Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWERM3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWERM3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWERM3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:29:45 -0400
Received: from web81114.mail.mud.yahoo.com ([68.142.199.46]:29793 "HELO
	web81114.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751349AbWERM3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:29:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ameritech.net;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wWFG8wiX4W2RRbxybenbZG6Al+oFk80sFO5nuGEE1GifwPWYWdefQgoytODd1NoVxGebe4vVZXBAUtylDR9EUB8B9iEYyLgbPWO7zMTPRTnfCTCHUIrhwqaG/mN7DPPvSkvjl0LEargA7nWxXZcmX69pq6ZGBnlPWS7XU7reGsE=  ;
Message-ID: <20060518122944.66148.qmail@web81114.mail.mud.yahoo.com>
Date: Thu, 18 May 2006 05:29:44 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [patch] add input_enable_device()
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <446BFE01.7030103@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Stas Sergeev <stsp@aknet.ru> wrote:

> Dmitry Torokhov wrote:
> >>>> Why does it have the INPUT_DEVICE_ID_MATCH_BUS after all?
> >>> For userspace benefits.
> >> How exactly does the userspace benefit from the
> >> INPUT_DEVICE_ID_MATCH_BUS thing?
> This is still not answered. If INPUT_DEVICE_ID_MATCH_BUS
> is there, then I don't see the argument that the input
> layer is not designed for the like things.

Yes, you are right. INPUT_DEVICE_ID_MATCH_BUS will not likely
benefit anyone. It is highly unlikely that we would have a handler
for devices on specific bus or for devices made only by one vendor.
When I mentioned userspace I was talk ing about exporting bus,
product, vendor and version values to userspace which might be
still benefitial. Although as we move along to sysfsifying the
kernel bus information can be traced through sysfs instead.

> 
> > You just do not want to implement proper access control for the
> > hardware, that's it.
> Depends on an answer to the question above, whether using
> input is the proper way or not.
> 

Consider this: pcspkr is broken at the moment as it does not
handle several simultaneous events well. If you fix it do behave
properly with SND_TONE and SND_BELL arriving at the same time
then adding hooks to the speaker code for snd-pcsp should be
pretty easy. See?

--
Dmitry
