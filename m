Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbTBLSI6>; Wed, 12 Feb 2003 13:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTBLSI6>; Wed, 12 Feb 2003 13:08:58 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63887 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267387AbTBLSI5>;
	Wed, 12 Feb 2003 13:08:57 -0500
Date: Wed, 12 Feb 2003 18:13:46 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212181346.GC19921@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212075048.GA9049@wotan.suse.de> <20030212102741.GC10422@bjl1.jlokier.co.uk> <20030212104508.GA1273@wotan.suse.de> <20030212185200.A629@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212185200.A629@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 06:52:00PM +0100, Ingo Oeser wrote:
 > On Wed, Feb 12, 2003 at 11:45:08AM +0100, Andi Kleen wrote:
 > > [...] I have no real interest in vm86 mode, perhaps one of the people
 > > interested in dosemu etc. could take care of it. I'm very glad it doesn't
 > > exist on my main architecture - x86-64 - given how many hacks it needs to be 
 > > supported.
 > 
 > So what about making it a CONFIG_XXX option? The few dosemu users
 > could then configure it in.

Overkill. Andi's TF_VM86 fix looks to be the nicest way to do it.
If you don't use dosemu etc, the wrmsr should never be hit.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
