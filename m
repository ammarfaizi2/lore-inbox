Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbTCTPyo>; Thu, 20 Mar 2003 10:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbTCTPyn>; Thu, 20 Mar 2003 10:54:43 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21633
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id <S261535AbTCTPyk> convert rfc822-to-8bit; Thu, 20 Mar 2003 10:54:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Tue, 18 Mar 2003 20:22:05 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <629040000.1045013743@flay> <m1of5gwyhq.fsf@frodo.biederman.org> <20030213180705.GB27560@wotan.suse.de>
In-Reply-To: <20030213180705.GB27560@wotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303182022.05358.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 February 2003 13:07, Andi Kleen wrote:
> [Hmm, this is becomming a FAQ]
>
> > Switching in and out of long mode is evil enough that I don't think it
> > is worth it.  And encouraging people to write good JIT compiling
>
> Forget it. It is completely undefined in the architecture what happens
> then. You'll lose interrupts and everything. Nothing for an operating
> system intended to be stable.
>
> I have no plans at all to even think about it for Linux/x86-64.
>
> > emulators sounds much better, especially in the long run.  But it can
> > be written.
>
> For DOS even a slow emulator should be good enough. After all most
> DOS Programs are written for slow machines. Bochs running on a K8
> will be hopefully fast enough. If not an JIT can be written, perhaps
> you can extend valgrind for it.

Fabrice Bellard, the author of TCC (Tiny C Compiler) seems to have taken it 
into his head that Bochs and Valgrind are too slow, and his current pet 
project is writing a new hand-optimized, portable JIT x86 emulator.  So 
there's one in the works already... :)

(See the tinycc-devel@nongnu.org archives for details, just this past weekend 
in fact...)

Rob

-- 
penguicon.sf.net - A combination Linux Expo and Science Fiction Convention, 
May 2-4 2003 in Warren, Michigan. Tutorials, installfest, filk, masquerade...


