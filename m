Return-Path: <linux-kernel-owner+w=401wt.eu-S964771AbXAGQYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbXAGQYX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964770AbXAGQYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:24:23 -0500
Received: from ylug.da-cha.jp ([61.211.239.235]:59010 "EHLO maison.kyo-ko.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932603AbXAGQYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:24:22 -0500
X-Greylist: delayed 1447 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 11:24:22 EST
Message-ID: <45A11900.3020302@da-cha.org>
Date: Mon, 08 Jan 2007 01:00:00 +0900
From: Hiroshi Miura <miura@da-cha.org>
User-Agent: IceDove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: TAKADA <takada@mbf.nifty.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386,2.6 cyrix.c cann't found companion chip
References: <20070107094738.21919.qmail@smb516.nifty.com>
In-Reply-To: <20070107094738.21919.qmail@smb516.nifty.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takada-san,

It is  obviously bad.
These part is added several years ago by my post.
A cyrix.c try to find chip because of chip hardware bug affected
to timer which has started early.

Now, these chips have already been obsolete.
There are 2 options. One is simply remove these functionality.
The other is to move it to compile time ifdef that is off by default.

For user who use in embbeded environment,
I wanna change it to ifdef.

Thank you for report!

Hiroshi

TAKADA wrote:
> Hi. I use MediaGX with kernel 2.6.19.
> cirix.c try to find companion chip (CS5510 and CS5520) with
> pci_devPresent().
> However, cyrix.c cannot find a companion chip because a list of
> pci_devices is not yet initialized when __cpuinit is called.
> Therefore, Search functions such as the 2.4 kernel which pci_devices
> list is needless is necessary.
> 
> How will it be good?
> 

