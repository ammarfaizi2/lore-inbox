Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSK0TMr>; Wed, 27 Nov 2002 14:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSK0TMr>; Wed, 27 Nov 2002 14:12:47 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:41423 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S264690AbSK0TMq>;
	Wed, 27 Nov 2002 14:12:46 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Lee Leahu <lee@ricis.com>
Date: Wed, 27 Nov 2002 20:19:50 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vmware + aic7xxx + 2.4.19-4gb-smp = kernel panic
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <8BB282713D2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 02 at 12:58, Lee Leahu wrote:
> 
> my hardware is this:
> 
> 2 pentium III 1.13 gb processors
> tyan motharboard w/ via chipset
> 1.5 gb ram
> 
> adaptec 2490 scsi card.
> plextor cd re-writer 8/2/20
> 
> sound blaster live card
> 
> -----------------------------------------------------------
> 
> problem description:
> 
> when i have vmware up and running w2k server,
> and i burn a cd from bash (as root) using cdrecord,
> i am getting a kernel panic.
> 
> also to note,  the emu10k1 sound driver is loaded with xmms playing mp3s.

How is your virtual machine configured? Do you use
/dev/sg* for generic access to your SCSI, or
/dev/sr* for accessing your CD drive from virtual machine? 

In that case, try disconnecting this hardware from guest before
using cdrecord. It is quite possible that your cdwriter gets mad
if you are recording and at same time Windows try to detect whether
you changed medium inside writer...

Not that aic7xxx driver should panic due to that, but...
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
