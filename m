Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbVLRVuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbVLRVuL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 16:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVLRVuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 16:50:10 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:26464 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965280AbVLRVuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 16:50:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SSUGLMihjhGVynNvem/HvULN++3zL6q2w1DbAQ8HDyA9wKk8Bib/+9fStk9MYGH8y02gGi/+qfaIvCD+aOPmfSRvpIBqma9RZjCg0ecLXDrguQrvhX7NXa/+9bdnIrw2IVvwtCN5bvlbq9XPFdm2XHyNnLljyza6NJC7aeJGF7w=
Message-ID: <43A5D963.9020201@gmail.com>
Date: Mon, 19 Dec 2005 05:49:23 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Sebastian Kaergel <mailing@wodkahexe.de>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.14.4 [intelfb problem]
References: <20051215005041.GB4148@kroah.com> <20051218204253.b32a4f61.mailing@wodkahexe.de>
In-Reply-To: <20051218204253.b32a4f61.mailing@wodkahexe.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kaergel wrote:
> Hi,
> 
> after installing 2.6.14.4 I'm no longer able to use my intelfb-console.
> 
> .config is exactly the same as with 2.6.14.3, but 2.6.14.4 doesn't
> switch to fb at all. Just the normal console appears.
> 
> dmesg output:
> <snip>
> intelfb: Video mode must be programmed at boot time.
> <snip>

This means that the BIOS was unable to switch the adapter to graphics mode
with...

> 
> lilo.conf:
> vga=791

...this parameter.

Sometimes, this is just a problem with the bootloader not recognizing
the option parameters.

> image=/boot/2.6.14.4-3
>  append="video=intelfb"

'cat /proc/cmdline' should confirm if your options where actually passed
unchanged to the kernel.

Tony
