Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130380AbQK2LkE>; Wed, 29 Nov 2000 06:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130587AbQK2Ljx>; Wed, 29 Nov 2000 06:39:53 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:46598 "EHLO mx1.eskimo.com")
        by vger.kernel.org with ESMTP id <S130380AbQK2Ljh>;
        Wed, 29 Nov 2000 06:39:37 -0500
Date: Wed, 29 Nov 2000 03:09:06 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
Reply-To: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reproducible 2.2.1x nethangs (dma?)
Message-ID: <Pine.SUN.3.96.1001129013833.22146A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm. Memory corruption (shows up in the args of a traced httpd process
sitting on it's stack), concurrent with pci busmastering ethernet yes,
concurrent with localhost connect to same server no (just tried it
with 20 times the number of connects from local client that reliably
hang it over ethernet, didn't flinch; same SIGCHLD during accept()
events showed in the log, but never with the httpd parent's stack
corrupted after accept() restarted).

Dma error? On connect only? (Doesn't happen during 100mb ftp transfers.)
(The ethernet card does support dma buffer management.)

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
