Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280707AbRKSVBw>; Mon, 19 Nov 2001 16:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280709AbRKSVBm>; Mon, 19 Nov 2001 16:01:42 -0500
Received: from mta40-acc.tin.it ([212.216.176.93]:41976 "EHLO fep40-svc.tin.it")
	by vger.kernel.org with ESMTP id <S280707AbRKSVBh>;
	Mon, 19 Nov 2001 16:01:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Flavio Stanchina <flavio.stanchina@tin.it>
Organization: not at all
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 22:01:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl> <E165sA9-0006Nv-00@mauve.csi.cam.ac.uk> <01111919395802.07749@nemo>
In-Reply-To: <01111919395802.07749@nemo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011119210132.BLZC10632.fep40-svc.tin.it@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 20:39, vda wrote:

> Patches for chmod source would be better. Perhaps I should do that...
> Let's refrain from "you're fool... go read manpage" type
> discussions. Not productive.

Calling you a fool would certainly be stupid, however you are arguing 
about a feature that Unix filesystems have had since the beginning of time 
and that every sysadmin uses quite frequently (as described in several 
posts) so you're not going to get much support, not on LKML at least. ;-)

Patching chmod to add a new option would save some typing once in a while, 
but if you find yourself doing such chmod'ing often the very obvious 
solution (which was already proposed) is

  find -type d -exec chmod +x \{\} \;

eventually wrapped in a script, alias or whatever. That's what Unices are 
good for: you can easily build new utilities by combining existing ones, 
no need to patch anything.

Some might agree that assigning different purposes to the 'x' bit for 
files and directories might be confusing, but there's a fix for that too: 
just think "eXplore" instead of "eXecute" when you look at directories.

Now one could start arguing about the setgid bit too, and that's more 
dangerous than the execute/explore bit, but again, it always worked that 
way and it ain't gonna change anytime soon.

-- 
Ciao,
    Flavio Stanchina
    Trento - Italy

"The best defense against logic is ignorance."
http://spazioweb.inwind.it/fstanchina/
