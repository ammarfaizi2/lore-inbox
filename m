Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129944AbQK2Dxs>; Tue, 28 Nov 2000 22:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130322AbQK2Dx2>; Tue, 28 Nov 2000 22:53:28 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:62304 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S129944AbQK2DxQ>; Tue, 28 Nov 2000 22:53:16 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Tigran Aivazian <tigran@veritas.com>, David Hinds <dhinds@valinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11) 
In-Reply-To: Your message of "Tue, 28 Nov 2000 17:53:48 MDT."
             <20001128175348.J8881@wire.cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Nov 2000 14:23:06 +1100
Message-ID: <7349.975468186@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000 17:53:48 -0600, 
Peter Samuelson <peter@cadcamlab.org> wrote:
>Binary patching?  If you are binary patching something you need to get
>the exact location, one way or another.  Whatever tool you use to
>extract the location of a symbol in an object file, that same tool
>should tell you which section it is in.  If the tool only looks in
>'.data', it is flawed.

The whole point of bss is that it does not have any space allocated in
the object on disk.  bss is just a section entry saying "this size, at
this location", the area is allocated and zeroed at load time.  Binary
patches against bss on disk cannot work, there is nothing to patch.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
