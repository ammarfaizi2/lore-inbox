Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132395AbRDCRgO>; Tue, 3 Apr 2001 13:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRDCRfy>; Tue, 3 Apr 2001 13:35:54 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:30982 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132389AbRDCRfv>; Tue, 3 Apr 2001 13:35:51 -0400
Message-ID: <3ACA09C0.C0D26BDF@vc.cvut.cz>
Date: Tue, 03 Apr 2001 10:34:56 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: James Simmons <jsimmons@linux-fbdev.org>
CC: thunder7@xs4all.nl,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: [lkml]Re: [lkml]Re: Matrox G400 Dualhead
In-Reply-To: <Pine.LNX.4.31.0104022013260.3867-100000@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> >A very neat trick. X can now be ended correctly. Unfortunately, any
> >scrolling on any VT afterwards gives me a corrupted screen - parts of
> >the screen from other VT's are inserted below, or over the cursor
> >position, and at 'half-line' intervals. In typing this email, I've seen
> >it 5 times already.
> >I'm willing to test anything - but the corruption is alway gone after I
> >switch VT's. So getting a screendump is not easy.
> 
> I never have seen this problem before. Petr do you know what it could be?

If you are still running X with enabled DRI, then it is known problem.
When
DRI is enabled in X, mga driver randomly reprograms some Matrox
acceleration
registers (color depth, screen width, byte ordering) - so you must use
same depth and resolution in both X and on console if you are using DRI.
I believe that it is problem which thunder7 sees. I never got reported
that
matroxfb just decided itself in the middle of screen to do something
else,
it was always tracked to X running on (invisible) background, but still
playing with accelerator.
								Petr

P.S.: You can try 'fbset -accel false', but fixing X is better.
Unfortunately,
nobody cares...
