Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKXGOV>; Fri, 24 Nov 2000 01:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131156AbQKXGOC>; Fri, 24 Nov 2000 01:14:02 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:21443 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129219AbQKXGNu>; Fri, 24 Nov 2000 01:13:50 -0500
Message-ID: <3A1DFFD0.22C8CEC3@haque.net>
Date: Fri, 24 Nov 2000 00:42:40 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.GSO.4.21.0011240006040.12702-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the error while I was compiling XFree86 4 CVS and kernel. So
that's what I've been doing in multiples along witha couple otehr things
thrown inthe mix to generate lots of disk i/o.

Nothing yet, but I'm pretty sure my machine hates me for putting it
through this.

Alexander Viro wrote:
> Bloody interesting. I don't see anything recent that could affect the
> areas in question. Intersting versions to check: 11-pre5 and 11-pre6.
> It smells like buffer cache corruption, but I don't see anything
> relevant. __generic_unplug_device() change loock pretty innocent,
> ditto for bh_kmap() ones in raid5 and on ext2 side we had two obviously
> equivalent replacements (pre5->pre6). No buffer.c changes, no VM ones.
> Urgh.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
