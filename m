Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbTF2CB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 22:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbTF2CB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 22:01:59 -0400
Received: from mailgate1.nau.edu ([134.114.96.58]:64176 "EHLO
	mailgate1.nau.edu") by vger.kernel.org with ESMTP id S265505AbTF2CB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 22:01:58 -0400
Date: Sat, 28 Jun 2003 19:10:18 -0700
From: Justin Pryzby <justinpryzby@users.sf.net>
Subject: Re: /dev/random broken?
In-reply-to: <E19WOvK-0001I7-00@andromeda>
To: "Luca T." <luca-t@libero.it>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030629021018.GA26162@andromeda>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <E19WOvK-0001I7-00@andromeda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/dev/urandom is what you want; it makes up its own entropy.  /dev/random
uses entropy from user input (low order bits I imagine).  I assume that
this is how other unixes work, too.

Justin

On Sun, Jun 29, 2003 at 02:16:02AM +0000, Luca T. wrote:
> 
> Hello,
> i am not sure if this is a kernel/module problem but so it seems to me.
> My computer is an AMD 2000+ with an ABIT motherboard, my kernel version
> is 2.4.21-0.13mdk (but i tried it with 2.4.21-0.18mdk too and it doesn't
> work either).
> 
> If i give this command:
>  dd if=/dev/zero of=./xxx bs=1024 count=100
> it will work perfectly. But if i try to do the same reading from
> /dev/random with this command:
>  dd if=/dev/random of=./xxx bs=1024 count=100
> it will just sit there and stare at me until i move the mouse... and
> then the program will exit without any error message (i checked in
> /var/log/messages too and there is no message there either about this).
> 
> Is this a bug? If yes... do you have any idea that would help me fix it?
> 
> Thank you,
>     Luca
> 
> -
> To unsubscribe from this list: send the line 'unsubscribe linux-kernel' in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
