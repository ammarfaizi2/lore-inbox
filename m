Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRDWW7M>; Mon, 23 Apr 2001 18:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbRDWW7A>; Mon, 23 Apr 2001 18:59:00 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:18449 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132516AbRDWW5m>;
	Mon, 23 Apr 2001 18:57:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.4.3: 3rdparty driver support for kbuild 
In-Reply-To: Your message of "Sun, 15 Apr 2001 05:25:24 EDT."
             <3AD96904.9274E46C@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 08:57:36 +1000
Message-ID: <12679.988066656@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Apr 2001 05:25:24 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>The attached patch, against kernel 2.4.4-pre3, adds a feature I call
>"3rd-party support."

Already covered by my 2.5 makefile rewrite[1] which has explicit
support for third party kernel source.  Shadow trees are designed
specifically to handle this problem.  I don't see the point of adding a
script which will only be used in 2.4, especially when the vendors
would have to change their tarball format for 2.5 formats.

(3) The kernel is constructed from multiple source trees and built in a
    separate object tree.

    As for (2) you have a separate object directory for each set of
    config options.  But instead of manually building a single source
    tree from various patches, the patch sets are kept separate and
    kbuild 2.5 logically constructs a single kernel source tree from
    the various source trees.  This is called a shadow tree system
    because the patch sets shadow the main kernel source tree.

[1] http://sourceforge.net/projects/kbuild


