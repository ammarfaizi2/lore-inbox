Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQKOWKJ>; Wed, 15 Nov 2000 17:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130789AbQKOWJ7>; Wed, 15 Nov 2000 17:09:59 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:40197 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129597AbQKOWJt>;
	Wed, 15 Nov 2000 17:09:49 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 15 Nov 2000 22:39:23 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: test11-pre5 breaks vmware
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <CF5004B75B8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 00 at 12:12, H. Peter Anvin wrote:
> Also, if a piece of software needs raw CPUID information (unlike the
> "cooked" one provided by recent kernels) it should use
> /dev/cpu/*/cpuid.

There are two problems, first breaking procfs field name for no good reason 
(you can name x86 features as 'flags' and amd/cyrix/...
as you named... There is certainly fewer apps which search 'flags'
for AMD feature than apps which search 'flags' for x86 feature;
you can also emulate old flags field by merging all features together,
but I'm not asking for this).

Second problem is that I know no system which has /dev/cpu/*/* file.
Maybe it is just my problem...

But if you could modify cpuid/msr registration interface so that they'll
appear on my /devfs, it would be much nicer. Currently there is only 
'microcode' and 'mtrr' in /devfs/cpu, and no 0,1 subdirectories...
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
