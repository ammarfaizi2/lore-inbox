Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVCKWL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVCKWL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVCKWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:11:29 -0500
Received: from smtp06.auna.com ([62.81.186.16]:41642 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261656AbVCKWLO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:11:14 -0500
Date: Fri, 11 Mar 2005 22:11:08 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: AGP bogosities
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, davej@redhat.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
In-Reply-To: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> (from
	paulus@samba.org on Fri Mar 11 02:24:54 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1110579068l.8904l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.11, Paul Mackerras wrote:
> Linus,
> 
...
> 
> Oh, and by the way, I have 3D working relatively well on my G5 with a
> 64-bit kernel (and 32-bit X server and clients), which is why I care
> about AGP 3.0 support. :)
> 

I think it is not a G5 only problem. I have a x8 card, a x8 slot, but
agpgart keeps saying this:

Mar 11 23:00:28 werewolf dm: Display manager startup succeeded
Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode 0xa. Fixed.
Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags (2) in AGP3 mode. Fixed.
Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode 0xa. Fixed.
Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags (2) in AGP3 mode. Fixed.
Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode

The nvidia driver (brand new 1.0-7167, now works with stock -mm) tells me
it is in x8 mode, but i suspect it lies....

Will try your patch right now.


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam3 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-6mdk)) #2


