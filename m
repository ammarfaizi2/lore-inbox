Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752182AbWCCIMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbWCCIMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbWCCIMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:12:12 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:18597 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752182AbWCCIML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:12:11 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Fri, 3 Mar 2006 09:12:11 +0100
User-Agent: KMail/1.9.1
Cc: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
       linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <mailman.1141249502.22706.linux-kernel2news@redhat.com> <20060302130519.588b18a2.zaitcev@redhat.com>
In-Reply-To: <20060302130519.588b18a2.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603030912.11622.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you ever considered how many TDs have to be allocated to transfer
> a data buffer this big? No, seriously. If your application cannot deliver
> the tranfer speeds with 16KB URBs, we ought to consider if the combination
> of our USB stack, usbfs, libusb and the application ought to get serious
> performance enhancing surgery. The problem is obviously in the software
> overhead.

If you queue a large number of 16KB urbs, rather than one jumbo urb,
does that make any difference to the number of TDs allocated?  I thought
TDs were allocated for all queued urbs at the moment they are queued...

Ciao,

Duncan.
