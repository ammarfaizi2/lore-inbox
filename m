Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbRBETWS>; Mon, 5 Feb 2001 14:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRBETWK>; Mon, 5 Feb 2001 14:22:10 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:1284 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130889AbRBETWB>;
	Mon, 5 Feb 2001 14:22:01 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Peter Horton <pdh@colonel-panic.com>
Date: Mon, 5 Feb 2001 20:20:41 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: VIA silent disk corruption - patch
CC: linux-kernel@vger.kernel.org, andre@linux-ide.org
X-mailer: Pegasus Mail v3.40
Message-ID: <14A3825B3E3F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Feb 01 at 19:05, Peter Horton wrote:

> Okay, looks like this fixes it (for me anyways).

> +    *  VIA VT8363 host bridge has broken feature 'PCI Master Read
> +    *  Caching'. It caches more than is good for it, sometimes
> +    *  serving the bus master with stale data. Some BIOSes enable
> +    *  it by default, so we disable it.

Hi,
  I'll try it today, though I'm not sure that it will fix lost last
dword on read. But at least it should stop corruption on write...
  After your mail I noticed that there is couple of `unsettable'
options in BIOS, and I did not tried switching BIOS from optimal to
slow setting yet, so maybe there are more broken optimizations?
  I'll keep you informed.
                                    Thanks,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
