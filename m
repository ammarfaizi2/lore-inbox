Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTKVRuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTKVRuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:50:40 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:57250 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262540AbTKVRui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:50:38 -0500
From: Frank Dekervel <kervel@drie.kotnet.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Date: Sat, 22 Nov 2003 18:50:36 +0100
User-Agent: KMail/1.5.93
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
References: <200311191749.28327.kervel@drie.kotnet.org> <200311201137.55553.kervel@drie.kotnet.org> <20031120072236.68327dca.akpm@osdl.org>
In-Reply-To: <20031120072236.68327dca.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200311221850.36503.kervel@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

something similar:

catting /proc/bus/pnp/devices makes my system oops, doing it twice makes my 
system crash :p

the oops looks very much like the oops (also bad EIP value, also no stack 
trace) i get on boot with the first patch (below) applied. As i already 
mailed, i need to revert that patch to make my system boot.

this oops happens with all 3 patches below reverted, so i guess it'll happen 
too with stock test9.

would the -mm5 pnp-fix-4.patch be worth a try ? it seems related

thanks,
greetings,
frank


Op Thursday 20 November 2003 16:22, schreef Andrew Morton:
> There are three pnpbios patches in -mm:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2
>.6.0-test9-mm4/broken-out/pnp-fix-1.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2
>.6.0-test9-mm4/broken-out/pnp-fix-2.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2
>.6.0-test9-mm4/broken-out/pnp-fix-3.patch
>
> It would help if you could determine which (if any) of these are causing
> the problem.  You can remove the patches with
>
>         cd /usr/src/linux
>         patch -p1 -R < ~/pnp-fix-3.patch

-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
