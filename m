Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288956AbSAISRg>; Wed, 9 Jan 2002 13:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288957AbSAISR1>; Wed, 9 Jan 2002 13:17:27 -0500
Received: from dialin-212-144-147-111.arcor-ip.net ([212.144.147.111]:22259
	"EHLO merv") by vger.kernel.org with ESMTP id <S288956AbSAISRS>;
	Wed, 9 Jan 2002 13:17:18 -0500
Date: Wed, 9 Jan 2002 19:17:58 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i810_audio.c .text.exit reference in 2.4.17
Message-ID: <20020109181758.GC586@informatik.tu-muenchen.de>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020104215040.GA3020@storm.local> <7131.1010210820@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7131.1010210820@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 05:07:00PM +1100, Keith Owens wrote:
> On Fri, 4 Jan 2002 22:50:40 +0100, 
> Andreas Bombe <bombe@informatik.tu-muenchen.de> wrote:
> >I just want to mention that i810_audio.c suffers from referencing a
> >symbol in .text.exit(i810_remove), too, with the usual symptoms.
> 
> If the reference is coming from .text.lock then there is a patch
> waiting for Marcelo to fix that.  If the reference is coming from
> another section then it is a bug.

So there are actually two kinds of those errors...  It was coming from
the PCI function table, referencing i810_remove for its remove entry.  I
fixed it locally with an #ifdef MODULE around that line.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
