Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132653AbRA3X2E>; Tue, 30 Jan 2001 18:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132917AbRA3X1z>; Tue, 30 Jan 2001 18:27:55 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:61197
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S132653AbRA3X1m>; Tue, 30 Jan 2001 18:27:42 -0500
Date: Tue, 30 Jan 2001 18:27:40 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol in 2.4.1 depmod.
Message-ID: <20010130182740.A10610@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
In-Reply-To: <Pine.SOL.4.20.0101301409420.20128-100000@garnet.tc.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Newsgroups: local.linux.kernel
In-Reply-To: <4924.980894540@ocs3.ocs-net>
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4924.980894540@ocs3.ocs-net> you write:
> On Tue, 30 Jan 2001 14:15:20 -0600 (CST), 
> Jason Michaelson <micha044@tc.umn.edu> wrote:
> >Greetings. I've just procured myself a copy of 2.4.1, and tried to build
> >it. At the tail end of a make modules_install, the following error occurs:
> >
> >depmod: *** Unresolved symbols in /lib/modules/2.4.1/kernel/drivers/md/md.o
> >depmod:         name_to_kdev_t
> 
> name_to_kdev_t is defined in init/main.c.  It is not exported so it
> cannot be called from modules.  name_to_kdev_t *cannot* be exported
> because it is defined as __init, the code has gone by the time the
> module is loaded.  Ask the md maintainer for a fix.

How did this used to work, then?  The call to name_to_kdev_t has been
in the md code since (according to the code comments) May, 2000; the
module worked fine as of 2.4.1-pre10, which is the last version I used.

-- 
Dave Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
