Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVKSWYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVKSWYd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVKSWYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 17:24:32 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:33542 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750963AbVKSWYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 17:24:32 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Avuton Olrich <avuton@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic: Machine check exception
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	<1132406652.5238.19.camel@localhost.localdomain>
	<3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
	<1132436886.19692.17.camel@localhost.localdomain>
From: Nix <nix@esperi.org.uk>
X-Emacs: the prosecution rests its case.
Date: Sat, 19 Nov 2005 22:24:17 +0000
In-Reply-To: <1132436886.19692.17.camel@localhost.localdomain> (Alan Cox's
 message of "19 Nov 2005 21:16:21 -0000")
Message-ID: <87ek5ce0oe.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 2005, Alan Cox stipulated:
> On Sad, 2005-11-19 at 12:54 -0800, Avuton Olrich wrote:
>> Is there a good way to narrow it down? I guess running a badmem
>> program would be good to start with, otherwise ...(?).
> 
> A memory test may be worth doing but most machine checks indicate the
> fault is more serious than bad memory.

Some of them are certainly not very serious in their effects. I get this
persistently, once every couple of months, on one of my machines (an
Athlon 4 with 768Mb of ECC RAM):

kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
kernel: Bank 2: 940040000000017a

and I think it *is* a single slightly wobbly bit (the wobble being too
slight for memtest to find).

Nothing discernible has ever gone wrong as a result of that, right down
to repeated GCC enable-checking bootstrap-and-tests completing without
error (well, without any more than the expected XFAILs).

(I'm just *assuming* the `Bank 2' in this message refers to a bank of
RAM. Doubtless this assumption will now be shown to be utterly wrong and
a sign of terminal foolishness on my part... ;) )

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

