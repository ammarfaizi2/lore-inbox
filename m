Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTJMSKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 14:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTJMSKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 14:10:54 -0400
Received: from smtp0.libero.it ([193.70.192.33]:34189 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S261825AbTJMSKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 14:10:53 -0400
Date: Mon, 13 Oct 2003 20:10:46 +0200
From: Ludovico Gardenghi <garden@despammed.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [despammed] Re: vfat corruption in 2.6.0?
Message-ID: <20031013181046.GA5832@ripieno.somiere.org>
References: <20031012095720.GA21405@ripieno.somiere.org> <87llrqjrxx.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llrqjrxx.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 02:18:02AM +0900, OGAWA Hirofumi wrote:

> > He has a quite big vfat partition (60 GB) created with mkfs.vfat; he
> > ran a program that had to write ~5000 files summing up to 18 GB but
> Can I get your program or how can I make it reproduce? Any hint?

It's quite simple: given a program than echoes a list of lines like

EVENT:xxxxx:something:somethingelse:somethingelsemore

with xxxxx a number (you can think this as a random number between 00000
and 05000)

I wrote a bash shell script that contains something like

./myprogram | grep ^EVENT | while read; do
	echo "$REPLY" >> "clientdata-${REPLY:6:5}"
done

That's all.

It continues up to ~6GB and 5000 different files then starts reading
the files back and so on. The problem *should* happen in the writing
phase.

> If it happen next time, please send the dmesg and .config.

Ok. I'll also ask him if he has a copy somewhere else, I think he sends
syslog messages to a remote machine too.

Ludovico
-- 
<dunadan@despammed.com>          #acheronte (irc.freenode.net) ICQ: 64483080
GPG ID: 07F89BB8              Jabber: garden@jabber.students.cs.unibo.it
-- This is signature nr. 1252
