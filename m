Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTJCLll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 07:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTJCLll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 07:41:41 -0400
Received: from VIA-PPPD24017.vianetworks.es ([213.236.24.17]:37098 "EHLO
	servidor.eurogaran.com") by vger.kernel.org with ESMTP
	id S263717AbTJCLlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 07:41:39 -0400
Date: Fri, 3 Oct 2003 13:41:36 +0200
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: If Linux is to be run with CPU cache disabled then this is no bug (but please tell me if so).
Message-ID: <20031003114136.GA11539@eurogaran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: =?iso-8859-1?Q?Juanjo_Garc=EDa_Carr=E9?= <juanjo@eurogaran.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-Foreword: I am not complaining; just hoping to help in developing
a better kernel.

-Symptom: When accelerating graphics, the machine freezes completely
(no response to emergency sys req keys or net access).
As a consequence, NOTHING GETS LOGGED (sorry).

-How to reproduce:
1) Use the following hardware:
	Radeon 9200 AGP graphics card.
	CPU PentiumII Deschutes  (Tried the same card on an Athlon machine
-all the rest being equal- and the problem did not happen).
	baseplate Tyan (This means Intel 440BX and Intel AGP bus 2x )

2) Enable in BIOS the CPU internal cache to "Write Back" mode.
(Either "Write Thru" or "Disabled" will eliminate the problem,
at the expense of an extremely low performance).

3) Use ANY Linux-2.6.0-test kernel, or ANY linux-2.4 kernel, (in which
case you will need an updated version for the radeon module).

4) Use XFree86 4.3.0 or over (for radeon acceleration support).

5) In the XF86Config-4 file, specify the chipset of a Radeon 9100 or another
radeon for which acceleration is already supported (I know this is not the
culprit factor, since -as I said before- it works on an Athlon machine).

6) In the XF86Config-4 file, make sure the option ForcePCIMode is off
(when it is enabled, everything works fine, safe for halving performance).
_ALL_ the other options are indifferent in order to reproduce the problem,
(even the option to use the XFree GPL radeon driver or the propietary
FireGL drivers from Ati).

7) Make sure the agpgart module (and the intel_agp module for 2.6 kernels)
are loaded before launching XFree.

8) Launch X. Everything seems to work; glxinfo says Yes as to direct
rendering. Now launch an OpenGL application, like glxgears: 
It runs for some instants, then becomes blocked, as the rest of the system.


Please reply with Cc to  juanjo@eurogaran.com  because I am not suscribed
to any kernel mailing list.

Thank you.

