Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVDQAFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVDQAFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 20:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVDQAFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 20:05:33 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:37900 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261211AbVDQAF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 20:05:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jms4k0Yf+bLa0F9a2gorbs1jiqsRh2aVwW58KndcoBuxHaXqKAANHAEBRMj5ineoYqKb1N+3tNCPOTdWKpAP715DKAg6LAhBkfyVv3y84NvbBSz/f70Q1Vfmkt521M5pA4KUVLC3to5qdtvRyn2xIucdsQGbc0i5qnMiWRg1tr4=
Message-ID: <21d7e9970504161705a129893@mail.gmail.com>
Date: Sun, 17 Apr 2005 10:05:27 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] tpm: Stop taking over the non-unique lpc bus PCI ID, Also timer, stack and enum fixes
Cc: Kylene Hall <kjhall@us.ibm.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
In-Reply-To: <20050415235250.GA24204@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0504151611390.24192@dyn95395164>
	 <20050415235250.GA24204@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NO!  DO NOT use pci_find_device().  It is broken for systems with pci
> hotplug (which means any pci system).  Please use the way the driver
> currently works, that is correct.

But its not an LPC driver, it only uses a small piece of the LPC, we
really do need some sort of bridge driver layer or something for
these, then other drivers can sit on top of that,

The DRM still uses pci_find_device for the exact same reason, the fb
drivers take the PCI device and we have been told we can't use the
proper interface, hence one of the needs to merge fb and DRM..

Dave.
