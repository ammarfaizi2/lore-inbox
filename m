Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135267AbRAYAod>; Wed, 24 Jan 2001 19:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbRAYAoX>; Wed, 24 Jan 2001 19:44:23 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56380 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S135267AbRAYAoJ>; Wed, 24 Jan 2001 19:44:09 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia modules install path 
In-Reply-To: Your message of "Thu, 25 Jan 2001 00:59:07 BST."
             <20010125005907.A5811@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jan 2001 11:43:57 +1100
Message-ID: <10418.980383437@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001 00:59:07 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>Just a silly question. The pcmcia modules in 2.4.x get installed in
>/lib/modules/`uname -r`/pcmcia, instead of
>/lib/modules/`uname -r`/kernel/<whatever>
>
>Is there any special reason for that or is just a harmelss buglet ?

Deliberate.  Old versions of pcmcia-cs used a hard coded insmod from
/lib/modules/`uname -r`/pcmcia.  Newer versions use modprobe and do not
care where the module is stored.  The pcmcia directory is a migration
aid and will disappear after kernel 2.4.1.  All entries under pcmcia
should be symlinks anyway.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
