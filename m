Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVAJSXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVAJSXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVAJSIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:08:23 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:6590 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262402AbVAJSFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:05:14 -0500
Date: Mon, 10 Jan 2005 19:00:52 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Adam Anthony <AAnthony@sbs.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /driver/net/wan/sbs520
Message-ID: <20050110180052.GA27528@electric-eye.fr.zoreil.com>
References: <4F23E557A0317D45864097982DE907941A32B1@pilotmail.sbscorp.sbs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F23E557A0317D45864097982DE907941A32B1@pilotmail.sbscorp.sbs.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Anthony <AAnthony@sbs.com> :
[...]
>        It would be great to receive some feedback on our work, and we hope
> that this driver will eventually be added to the kernel.

It will probably require a few extra steps:
- read Documentation/CodingStyle (mixed case, typedef from hell, ugly #ifdef);
- grep ^static
  -> no static functions ? Uh ?
- use non-obsolete API (pci_find_device in 2005 ?);
- convert the os independant wrappers.

Btw it would probably make sense 1) to figure out what can be merged with
the in-tree DSCC4 driver and 2) to integrate the driver with the existing
hdlc stack. Imho there is some duplicated work/code.

--
Ueimor
