Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWDRO7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWDRO7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWDRO7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:59:12 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:43479 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751041AbWDRO7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:59:11 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] binary firmware and modules
Date: Tue, 18 Apr 2006 16:59:04 +0200
User-Agent: KMail/1.9.1
Cc: Jon Masters <jonathan@jonmasters.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1145088656.23134.54.camel@localhost.localdomain> <200604181537.47183.duncan.sands@math.u-psud.fr> <1145370171.10255.58.camel@localhost>
In-Reply-To: <1145370171.10255.58.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604181659.04657.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

> we have two kind of devices that need firmware download. The easy and
> clean ones which need one or two files and these basically change not
> that often. In most cases these are the network or storage devices and
> for exactly these we need the MODULE_FIRMWARE() support to know which
> files have to be put into initrd.

> The messed up devices like the Speedtouch and maybe even some WiFi
> dongles are another story.

I don't know why you consider the speedtouch to be messed up.  What's
messed up is not the modems themselves, but the fact that we don't know
what modems exist, and how they differ in their firmware requirements.

Anyway, speedtouch users also need their firmware to end up in any initrd.
Since the driver expects all firmware files to start with "speedtch",
the MODULE_FIRMWARE scheme would work for the speedtouch driver too as
long as it allows the driver to specify just the initial part of a file
name.  You could go all the way to regular expressions, but that seems
a bit ridiculous.

Ciao,

Duncan.
