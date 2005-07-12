Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVGLUM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVGLUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGLUMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:12:37 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:14216 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262481AbVGLULo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:11:44 -0400
Date: Tue, 12 Jul 2005 22:11:21 +0200
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: synaptics touchpad not recognized by Xorg X server with recent -mm kernels
Message-ID: <20050712201121.GA5587@gamma.logic.tuwien.ac.at>
References: <20050712172504.GD24820@gamma.logic.tuwien.ac.at> <m3fyujq5cf.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3fyujq5cf.fsf@telia.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 12 Jul 2005, Peter Osterlund wrote:
> What's the output from "cat /proc/bus/input/devices"?

good (rc1-mm1)
$ cat /proc/bus/input/devices 
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0 
B: EV=120013 
B: KEY=4 f2000000 3802078 f870f401 f2ffffdf ffefffff ffffffff ffffffff 
B: MSC=10 
B: LED=7 

I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event1 
B: EV=b 
B: KEY=6420 0 7000f 0 0 0 0 0 0 0 0 
B: ABS=11000003 

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name=""
P: Phys=
H: Handlers=kbd event2 
B: EV=3 
B: KEY=ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 

bad (rc2-mm2)
$ cat /proc/bus/input/devices 
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0 
B: EV=120013 
B: KEY=4 f2000000 3802078 f870f401 f2ffffdf ffefffff ffffffff ffffffff 
B: MSC=10 
B: LED=7 

I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event1 
B: EV=b 
B: KEY=6420 0 7000f 0 0 0 0 0 0 0 0 
B: ABS=11000003 

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SNITTERFIELD (n.)
Office noticeboard on which snitters (q.v.), cards saying 'You don't
have to be mad to work here, but if you are it helps !!!' and slightly
smutty postcards from Ibiza get pinned up by snitterbies (q.v.)
			--- Douglas Adams, The Meaning of Liff
