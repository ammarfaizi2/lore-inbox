Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTBLSMb>; Wed, 12 Feb 2003 13:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbTBLSMb>; Wed, 12 Feb 2003 13:12:31 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:17280 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S267361AbTBLSMa>; Wed, 12 Feb 2003 13:12:30 -0500
Date: Wed, 12 Feb 2003 18:23:05 +0000
From: Jamie Lokier <jamie@shareable.org>
To: mika.penttila@kolumbus.fi
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212182305.GA12039@bjl1.jlokier.co.uk>
References: <20030212141933.CKGK3999.fep19-app.kolumbus.fi@[193.229.5.109]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212141933.CKGK3999.fep19-app.kolumbus.fi@[193.229.5.109]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mika.penttila@kolumbus.fi wrote:
> BTW, why is sysenter supposed to be disabled while in vm86? And if
> it should be disabled (as now in sys_vm86), the next context switch
> back to the vm86 process re-enables it, in load_esp0, right? So what's
> the gain?

I quite misread the code in entry.S at ret_from_int.  The comment
"returning to kernel or vm86-space" confused me - of course scheduling
happens in vm86 mode.

(Andi et al., forget anything I've said about CONFIG_PREEMPT problems! :).

-- Jamie
