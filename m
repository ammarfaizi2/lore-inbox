Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUG2PBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUG2PBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUG2PAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:00:52 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:45793 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S265087AbUG2OIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:46 -0400
From: David Brownell <david-b@pacbell.net>
To: ncunningham@linuxmail.org
Subject: Re: fixing usb suspend/resuming
Date: Thu, 29 Jul 2004 07:07:18 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <20040729083543.GG21889@openzaurus.ucw.cz> <1091103438.2703.13.camel@desktop.cunninghams>
In-Reply-To: <1091103438.2703.13.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407290707.18751.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 July 2004 05:17, Nigel Cunningham wrote:
> 
> Regarding the spinning down before suspending to disk, I have a patch in
> my version that adds support for excluding part of the device tree when
> calling drivers_suspend. 

I've always suspected such a patch would be needed ... :)

The drivers/base/power code is a bit too simplistic right now.
Among other things it keeps deadlocking when suspend()
or resume() routines try to remove devices.  That makes
it needlessly hard to handle some common situations.

-  Dave
