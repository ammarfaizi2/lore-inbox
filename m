Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbUK2WZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUK2WZQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUK2WZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:25:16 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37556 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261837AbUK2WYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:24:02 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Stefan Seyfried <seife@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <41AAED32.2010703@suse.de>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams> <41AAED32.2010703@suse.de>
Content-Type: text/plain
Message-Id: <1101766833.4343.425.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 30 Nov 2004 09:20:33 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-11-29 at 20:34, Stefan Seyfried wrote:
> Nigel Cunningham wrote:
> 
> > The cryptoapi provides support for both compression and encryption. I'd
> > happily make use of that, but we still need a way for the user to choose
> > what compression/encryption they want and configure it. I'm not at all
> 
> And encryption is in fact much more needed than compression. Remember,
> you are writing everything in memory (including maybe ssh passphrases or
> gpg keys) to swap in clear text. Not nice. And i agree that compression
> is nice to have, too.
> 
> >>>:> But not everyone who uses 2.6.9 uses swsusp. :>
> 
> and not everyone who downloads suspend2 uses it ;-)

Yes... I'd say the relative percentage would be much higher, though.

> > change a parameter or forcing them to do an ls in /dev with obscure
> > parameters (to get the major and minor numbers) when they already know
> > they want /dev/sda1 isn't user friendly. Obviously user friendliness is 
> 
> This can easily be done by a userspace helper. You do use the
> (userspace) X server to display your GUI, don't you?

No. Not at all. All of userspace is well and truly wedged in a block of
ice by then.

> Putting only the absolutely necessary things into the kernel (the same
> is true for the interactive resume thing - if someone wants interactive
> startup at a failing resume, he has to use an initrd, i don't see a
> problem with that) will probably increase the acceptance a bit :-)

That's fine if your initrd is properly configured and you're willing to
add extra cruft to the kernel so userspace can get the info it needs,
and report what the user wants to do. If, however, you don't use an
initrd, you're sunk.

Regarding acceptance, there's no point in getting it accepted into the
kernel if we end up with something that's user-unfriendly. I think it
will help a lot if we agree that suspend does need to blur the lines
between kernel and userspace a little, in the interests of providing
software that is superior.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

