Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbTBRSo5>; Tue, 18 Feb 2003 13:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268051AbTBRSo5>; Tue, 18 Feb 2003 13:44:57 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:36579 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268045AbTBRSou>; Tue, 18 Feb 2003 13:44:50 -0500
Message-Id: <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 18 Feb 2003 10:50:49 -0800
To: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Rusty Russell <rusty@rustcorp.com.au>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030217.194612.131926469.davem@redhat.com>
References: <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
 <Pine.LNX.4.33.0301020341140.2038-100000@champ.qualcomm.com>
 <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:46 PM 2/17/2003, David S. Miller wrote:

>After talking to Alexey, I don't like this patch.
>
>The new module subsystem was supposed to deal with things
>like this cleanly, and this patch is merely a hack to cover
>up for it's shortcomings.
No it's not. Are you guys saying that module refcounting in net/core/dev.c 
is a hack too ? Patch that I sent implements exactly the same logic.
Grab module reference before creating net family socket and release
module when socket is gone. Where is the hack here ?

>To be honest, I'd rather just disallow module unloading or
>let them stay buggy than put this hack into the tree.
This comment makes no sense to me. Especially "let them stay buggy" part ;-).
(I wonder what Alex could have told you).

>Special hacks are for 2.4.x where things like full cleanups are not allowed.
It's not a special hack. If it has problems let's fix them.
I want to keep Bluetooth socket modules loadable and unloadable. And I'm sure
Jean and other folks want's the same thing for IrDA and other subsystems with sockets. 
So, you guys would have to come with a better argument than "ohh it's an ugly hack" ;-).

Alexey, could you please post what you told Dave here ?
Rusty, any comments from you ?

Here is the link to the patch that I sent
        http://marc.theaimsgroup.com/?l=linux-kernel&m=104308300808557&w=2

and here is some explanation about protocol families
        http://marc.theaimsgroup.com/?l=linux-kernel&m=104317832227499&w=2

Dave, Alex, seriously let's come up with the solution rather than ignoring
the problem. I think my patch is a good solution. If you don't like overhead 
or whatever else let's fix that.

Thanks
Max

