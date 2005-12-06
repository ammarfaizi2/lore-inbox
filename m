Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbVLFAVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbVLFAVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVLFAVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:21:36 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:2017 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751511AbVLFAVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:21:35 -0500
Date: Tue, 6 Dec 2005 01:19:34 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: broonie@sirena.org.uk
Cc: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
       Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] natsemi: NAPI support
Message-ID: <20051206001934.GA18329@electric-eye.fr.zoreil.com>
References: <20051204224734.GA12962@sirena.org.uk> <20051204231209.GA28949@electric-eye.fr.zoreil.com> <20051205232301.GA4551@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205232301.GA4551@sirena.org.uk>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@sirena.org.uk> :
[...]
> I had been under the impression that the stack was supposed to make sure
> that no poll() is running before the driver close() gets called ?

Not exactly. dev_close() waits a bit but it can not be sure that the
device driver will not schedule ->poll() from its irq handler later.

--
Ueimor
