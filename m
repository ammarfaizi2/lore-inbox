Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKOABq>; Tue, 14 Nov 2000 19:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQKOABg>; Tue, 14 Nov 2000 19:01:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:51471 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130682AbQKOAB2>;
	Tue, 14 Nov 2000 19:01:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Timur Tabi <ttabi@interactivesi.com>
cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "couldn't find the kernel version the module was compiled for" - help! 
In-Reply-To: Your message of "Tue, 14 Nov 2000 15:58:38 MDT."
             <20001114222843Z131509-521+212@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Nov 2000 10:31:22 +1100
Message-ID: <11946.974244682@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000 15:58:38 -0600, 
Timur Tabi <ttabi@interactivesi.com> wrote:
>First, I had a bunch of link errors on the redifintion of
>__module_kernel_version.  To fix that, someone told me to do this:
>
>#define __NO_VERSION__
>#include <linux/version.h>

"#define __NO_VERSION__" must be in all but one of the sources that
also include module.h.  It suppresses the module_version string in
module.h so it only make sense if the code includes module.h.  But
exactly one of the objects in a module must have a module_version
string.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
