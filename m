Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130677AbRA3Wmr>; Tue, 30 Jan 2001 17:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132446AbRA3Wmg>; Tue, 30 Jan 2001 17:42:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:24587 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130677AbRA3Wmb>;
	Tue, 30 Jan 2001 17:42:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jason Michaelson <micha044@tc.umn.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol in 2.4.1 depmod. 
In-Reply-To: Your message of "Tue, 30 Jan 2001 14:15:20 MDT."
             <Pine.SOL.4.20.0101301409420.20128-100000@garnet.tc.umn.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 09:42:20 +1100
Message-ID: <4924.980894540@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 14:15:20 -0600 (CST), 
Jason Michaelson <micha044@tc.umn.edu> wrote:
>Greetings. I've just procured myself a copy of 2.4.1, and tried to build
>it. At the tail end of a make modules_install, the following error occurs:
>
>depmod: *** Unresolved symbols in /lib/modules/2.4.1/kernel/drivers/md/md.o
>depmod:         name_to_kdev_t

name_to_kdev_t is defined in init/main.c.  It is not exported so it
cannot be called from modules.  name_to_kdev_t *cannot* be exported
because it is defined as __init, the code has gone by the time the
module is loaded.  Ask the md maintainer for a fix.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
