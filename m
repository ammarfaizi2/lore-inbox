Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbRAFUxv>; Sat, 6 Jan 2001 15:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132913AbRAFUxl>; Sat, 6 Jan 2001 15:53:41 -0500
Received: from jalon.able.es ([212.97.163.2]:2485 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132912AbRAFUxf>;
	Sat, 6 Jan 2001 15:53:35 -0500
Date: Sat, 6 Jan 2001 21:53:24 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: georgek@netwrx1.com
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.4.0 Module compile error
Message-ID: <20010106215324.A1155@werewolf.able.es>
In-Reply-To: <ek0c5t404dfib22jc6je0dldkj57e07k7d@4ax.com> <17981.978766533@ocs3.ocs-net> <lbje5t4stsj4haas107qjc2vgn180285nv@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <lbje5t4stsj4haas107qjc2vgn180285nv@4ax.com>; from georgek@netwrx1.com on Sat, Jan 06, 2001 at 17:54:00 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.06 George R . Kasica wrote:
> 
> Here it is....what do I need to fix on it:
> 
> >[root@eagle 2.4.0]# cd /etc
> >[root@eagle /etc]# more modules.conf
> >keep
> >
> >path[usb]=/lib/modules/`uname -r`/`uname -v`
                                     ^^^^^^^^^
??????
$ uname -v
#6 SMP Sat Jan 6 01:38:26 CET 2001

> >path[usb]=/lib/modules/`uname -r`
> >path[usb]=/lib/modules/
> >path[usb]=/lib/modules/default
> >

Delete all that stuff 'path[usb]' from /etc/modules.conf. It
is confusing your modutils. Paths should begin with
/lib/modules/`uname -r`/kernel, I think. But it is safer to
delete them.

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.4.0-ac2 #6 SMP Sat Jan 6 01:38:26 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
