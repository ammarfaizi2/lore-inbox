Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUK2LIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUK2LIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUK2LG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:06:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:9372 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261656AbUK2LEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:04:37 -0500
Message-ID: <41AAED32.2010703@suse.de>
Date: Mon, 29 Nov 2004 10:34:42 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend 2 merge
References: <1101292194.5805.180.camel@desktop.cunninghams>	 <20041124132839.GA13145@infradead.org>	 <1101329104.3425.40.camel@desktop.cunninghams>	 <20041125192016.GA1302@elf.ucw.cz>	 <1101422088.27250.93.camel@desktop.cunninghams>	 <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams>
In-Reply-To: <1101426416.27250.147.camel@desktop.cunninghams>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> The cryptoapi provides support for both compression and encryption. I'd
> happily make use of that, but we still need a way for the user to choose
> what compression/encryption they want and configure it. I'm not at all

And encryption is in fact much more needed than compression. Remember,
you are writing everything in memory (including maybe ssh passphrases or
gpg keys) to swap in clear text. Not nice. And i agree that compression
is nice to have, too.

>>>:> But not everyone who uses 2.6.9 uses swsusp. :>

and not everyone who downloads suspend2 uses it ;-)

> change a parameter or forcing them to do an ls in /dev with obscure
> parameters (to get the major and minor numbers) when they already know
> they want /dev/sda1 isn't user friendly. Obviously user friendliness is 

This can easily be done by a userspace helper. You do use the
(userspace) X server to display your GUI, don't you?
Putting only the absolutely necessary things into the kernel (the same
is true for the interactive resume thing - if someone wants interactive
startup at a failing resume, he has to use an initrd, i don't see a
problem with that) will probably increase the acceptance a bit :-)

Best regards,

   Stefan

