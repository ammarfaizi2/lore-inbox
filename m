Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVJXJb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVJXJb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 05:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVJXJb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 05:31:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:38085 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750818AbVJXJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 05:31:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: James Hansen <linux-kernel-list@f0rmula.com>
Subject: Re: Information on ioctl32
Date: Mon, 24 Oct 2005 11:32:42 +0200
User-Agent: KMail/1.7.2
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <4358CF73.3020602@f0rmula.com> <200510231603.58364.arnd@arndb.de> <435CA241.8050605@f0rmula.com>
In-Reply-To: <435CA241.8050605@f0rmula.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510241132.45334.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 24 Oktober 2005 10:58, James Hansen wrote:
>  From what they say over on lwn.net, I need to apply a patch, but my 
> current kernel (debian for amd64) is already trying to call it ioctl32.

No, you should not need to apply any patch, the compat_ioctl
infrastructure has been in there since 2.6.11. The old dynamic
ioctl32 subsystem has been removed for 2.6.14.

> Problem is, the kernel headers don't seem to have an entry in the 
> file_operations struct for compat_ioctl.  Does anyone know if there's 
> any other place (struct) I should be looking to put this function?
> 
> I thought it a bit odd that the prebuilt default kernel is trying to 
> call this function, but the headers for this kernel don't seem to allow 
> me to insert it into the fops struct.

You seem to be mixing up stuff. Are you looking at the headers in
the kernel source tree or another copy? Are you sure you are running
a recent kernel level?

	Arnd <><
