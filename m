Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271060AbRHUB7H>; Mon, 20 Aug 2001 21:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271071AbRHUB65>; Mon, 20 Aug 2001 21:58:57 -0400
Received: from rj.SGI.COM ([204.94.215.100]:61116 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271060AbRHUB6m>;
	Mon, 20 Aug 2001 21:58:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver that does not need db library? 
In-Reply-To: Your message of "Thu, 16 Aug 2001 09:44:26 MST."
             <200108161644.JAA02547@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 11:58:45 +1000
Message-ID: <17810.998359125@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001 09:44:26 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	Currently, building Justin Gibbs's otherwise excellent
>aic7xxx driver requires the Berkeley DB library, because the
>aic7xxx assembler that is used in the build process uses db
>basically just to implement associative arrays in memory.
>
>	Unfortunately, I'm currently wrestling with db version
>problems because gnome evolution requires the GPL'ed Sleepycat db 3.x,
>so I want to keep db-1.85 around also, and this breaks the aicasm
>build.

(A) Do not check "build aic7xxx firmware".

(B) kbuild 2.5 only selects the db*.h file that matches the current db
    library, instead of assuming that the first db*.h that it can find
    should be used.

(C) If the aic7xxx maintainer would let me fix the aic7xxx kbuild
    files, nobody would ever have these problems again.

