Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144399AbRA1Wal>; Sun, 28 Jan 2001 17:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144398AbRA1Wab>; Sun, 28 Jan 2001 17:30:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:61198 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S144272AbRA1WaP>;
	Sun, 28 Jan 2001 17:30:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: "Sergey Kubushin" <ksi@cyberbills.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Peter Kaczuba <pepe@pool.informatik.rwth-aachen.de>, tytso@mit.edu
Subject: Ram disk problems in 2.4.0ac12 
In-Reply-To: Your message of "Fri, 26 Jan 2001 17:46:12 -0800."
             <Pine.LNX.4.31ksi3.0101261742080.598-100000@nomad.cyberbills.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Jan 2001 09:29:56 +1100
Message-ID: <9495.980720996@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001 17:46:12 -0800 (PST), 
"Sergey Kubushin" <ksi@cyberbills.com> wrote:
>Modules still don't load:
>
>=== Cut ===
>ide-mod.o: Can't handle sections of type 32131
>ide-probe-mod.o: Can't handle sections of type 256950710
>ide-disk.o: Can't handle sections of type 688840897
>ext2.o: Can't handle sections of type 69429248
>=== Cut ===

modutils has been ruled out as the cause of this problem.  The objects
are valid but when they are loaded they come up as corrupt.  Modules
work fine for me on 2.4.0-ac12, when they are loaded from disk.  Both
people reporting this bug are using initrd so the obvious culprit is
the ram disk code.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
