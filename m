Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUCUXoS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUCUXoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:44:18 -0500
Received: from magic.adaptec.com ([216.52.22.17]:29635 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261467AbUCUXoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:44:09 -0500
Message-ID: <405E287E.3080706@adaptec.com>
Date: Sun, 21 Mar 2004 16:42:54 -0700
From: Scott Long <scott_long@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20030817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-raid@vger.kernel.org, "Gibbs, Justin" <justin_gibbs@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com> <4058C089.9060603@adaptec.com> <200403172245.31842.bzolnier@elka.pw.edu.pl> <4058EBEC.8070309@adaptec.com> <1079788027.5225.4.camel@laptop.fenrus.com>
In-Reply-To: <1079788027.5225.4.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>With DM, what happens when your initrd gets accidentally corrupted?
> 
> 
> What happens if your vmlinuz accidentally gets corrupted? If your initrd
> is toast the module for your root fs doesn't load either. Duh.

The point here is to minimize points of failure.

> 
> 
>>What happens when the kernel and userland pieces get out of sync?
>>Maybe you are booting off of a single drive and only using DM arrays
>>for secondary storage, but maybe you're not.  If something goes wrong
>>with DM, how do you boot?
> 
> 
> If you loose 10 disks out of your raid array, how do you boot ?

That's a silly statement and has nothing to do with the argument.

> 
> 
>>Secondly, our target here is to interoperate with hardware components
>>that run outside the scope of Linux.  The HostRAID or DDF BIOS is
>>going to create an array using it's own format.  It's not going to
>>have any knowledge of DM config files, 
> 
> 
> DM doesn't need/use config files.
> 
>>initrd, ramfs, etc.  However,
>>the end user is still going to expect to be able to seamlessly install
>>onto that newly created array, maybe move that array to another system,
>>whatever, and have it all Just Work.  Has anyone heard of a hardware
>>RAID card that requires you to run OS-specific commands in order to
>>access the arrays on it?  Of course not.  The point here is to make
>>software raid just as easy to the end user.
> 
> 
> And that is an easy task for distribution makers (or actually the people
> who make the initrd creation software).
> 
> I'm sorry, I'm not buying your arguments and consider 100% the wrong
> direction. I'm hoping that someone with a bit more time than me will
> write the DDF device mapper target so that I can use it for my
> kernels... ;)
> 

Well, code speaks louder than words, as this group loves to say.  I 
eagerly await your code.  Barring that, I eagerly await a technical
argument, rather than an emotional "you're wrong because I'm right"
argument.

Scott

