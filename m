Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTHLMXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270283AbTHLMXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:23:31 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:53741 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S270256AbTHLMXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:23:25 -0400
Date: Tue, 12 Aug 2003 13:23:19 +0100 (BST)
From: mb <mb/lkml@dcs.qmul.ac.uk>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1, ext3 (external journal): nasty filesystem
 corruption under high load
In-Reply-To: <16184.54587.28573.816157@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.56.0308121320420.2147@r2-pc.dcs.qmul.ac.uk>
References: <Pine.LNX.4.56.0308121058230.2147@r2-pc.dcs.qmul.ac.uk>
 <16184.54587.28573.816157@gargle.gargle.HOWL>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (19mYBM-000619-8I)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19mYBQ-0004sw-I2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:53 +1000 Neil Brown wrote:

>> Admittedly I was being pathological, but I've got a new toy to play with!
>> Our new server is a dual-Athlon, 1.5G RAM (the other .5 failed memtest) +
>> about 6GB swap, with 15x70GB drives running under gdth.o with 12 as the
>> RAID-5 set, and the journal on 2 as a RAID-1 pair. System on IDE for now.
[snip]
>> Amazingly I could still ssh in to the box and discover that its load had
>> more than likely broken 1000. However, the compile started to complain
>> bitterly about non-ASCII characters in source files, and indeed corruption
>> did occur (random overwriting, it would appear).
>
>Almost certainly a raid5 bug, fix by the following patch.

Sorry, I should have made it clearer that it's hardware RAID--gdth.o is 
the driver for our ICP vortex card. (Actually of course it's gdth.ko)

Matt
