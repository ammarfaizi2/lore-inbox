Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277866AbRJ3UWa>; Tue, 30 Oct 2001 15:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJ3UWU>; Tue, 30 Oct 2001 15:22:20 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:30738 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S277756AbRJ3UWK>;
	Tue, 30 Oct 2001 15:22:10 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Manik Raina <manik@cisco.com>
Date: Tue, 30 Oct 2001 21:21:57 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] small compile warning fix
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <7C6E1BF47C4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You can remove it completely. It should not be '#ifdef LATER', but
> > '#ifdef OLDVERSION'... ncp_add_mem_fromfs was invoked with lock on
> > ncp_server structure, but then it directly accessed userspace. It was
> > possible to use this to cause deadlock, so now ncpfs uses bounce buffers
> > and double copy instead of this.
> >
> 
> would you include this in your patches or would you like me to make
> it #ifdef OLDVERSION ?

I removed ncp_add_mem_fromfs() from my tree...

> > I have some ncpfs patches, but I though that I'll leave them for 2.5.x.
> > Maybe it is time to change this decision.

... but as diff between my ncpfs and Alan's is about 30KB, I still did not
decide whether I'll send it for 2.4.x...
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                            
