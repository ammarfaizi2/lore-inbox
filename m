Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWC1MDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWC1MDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 07:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWC1MDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 07:03:38 -0500
Received: from aun.it.uu.se ([130.238.12.36]:26246 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932188AbWC1MDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 07:03:38 -0500
Date: Tue, 28 Mar 2006 14:02:54 +0200 (MEST)
Message-Id: <200603281202.k2SC2s8i022439@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: 2.6.16-git6: build failure: ne2k-pci: footbridge_defconfig
Cc: akpm@osdl.org, arjan@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006 17:40:14 +0000, Russell King wrote:
>> It's gcc 4.01... the kautobuild folk are going to try gcc 4.04 instead.
>
>Actually, given that it also appears with gcc 3.3, I'd like to request
>that the change (along with all the other const __devinitdata's) are
>backed out.
>
>The comments I'm hearing about gcc 4.1 on ARM indicate that it's a case
>of "there be big beasts there, don't touch with a barge pole".  To quote
>some comments about gcc 4.1 on ARM:
>
>"yeah, 4.1 is quite bad on arm.  it's supposed to have all the EABI bits,
> but it can't even build itself without ICEing and segfaulting left right
> and center"
>
>"the debian arm failures with gcc 4.1 are just scary.  the current gcc
> 4.1s miscompile even very basic for/while loops"
>
>which probably leaves ARM folk with a very narrow set of working gcc
>versions.
>
>So, I've no idea at present which gcc version we should be considering
>nominating as "the sole gcc version the kernel supports".

Just a data point...

My ARM GCCs are configured for the default arm-linux ABI,
not the EABI, and gcc-4.0.3 and gcc-4.1 both appear to be
solid for user-space code; they also bootstrap themselves
(on an ARM) just fine. I haven't used them for kernels however.

On the other hand, gcc-3.3.6 and gcc-3.4.6 both require several
add-on patches to fix incorrect code generation, and even then
there are a couple of known unfixed bugs (PR25133 and PR26463 in
particular; PR25133 can be worked around but PR26463 scares me).

/Mikael
