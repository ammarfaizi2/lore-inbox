Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKMKjP>; Mon, 13 Nov 2000 05:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQKMKjE>; Mon, 13 Nov 2000 05:39:04 -0500
Received: from Cantor.suse.de ([194.112.123.193]:30730 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129171AbQKMKis>;
	Mon, 13 Nov 2000 05:38:48 -0500
Date: Mon, 13 Nov 2000 11:38:23 +0100
From: Andi Kleen <ak@suse.de>
To: richardj_moore@uk.ibm.com
Cc: Andi Kleen <ak@suse.de>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001113113823.A24003@gruyere.muc.suse.de>
In-Reply-To: <80256996.00264A4F.00@d06mta06.portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <80256996.00264A4F.00@d06mta06.portsmouth.uk.ibm.com>; from richardj_moore@uk.ibm.com on Sun, Nov 12, 2000 at 11:27:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 11:27:26PM +0000, richardj_moore@uk.ibm.com wrote:
> 
> 
> 
> Andi Kleen wrote:
> > It will just help some people who have a unrational aversion against
> kernel
> >recompiles and believe in vendor blessed binaries.
> 
> 
> An interesting remark Andi, especially in the light of your note to me
> regarding your use of DProbes - i.e. you'd rather use DProbes to dump out
> some info from the kernel than recompile it with printks.

When I wrote it I was still misunderstanding GKHI's nature (I was assuming
that it worked on top of dprobes, not under it -- I should have read the 
source before commenting, my bad)

I think using dprobes for collecting information is ok, but when you want 
to do actual actions with it (not only using it as a debugger) IMHO it 
is better to patch and recompile the kernel. 

> 
> I don't have an aversion to recompiling the kernel - it's great fun - I
> love watching all the meeages go by, waiting with bated breath for a
> compile error, which never seems to happen. Just like watching the National
> Lottery, waiting for your own numbers to come up.
> 
> To be a little more serious, it's not recompilation that's a problem, its
> re-working a set of (non-standard) patches together. I'm not that excited
> by that - I'd rather develop new code than rework old. Anyway for a couple
> of  example scenarios see the response I made to Michael Rothwell.  And by
> the way, I absolutely agree with your approach to kernel problem solving -
> but wouldn't it be a help if you didn't have to put a large or even
> moderate effort into working the DProbes patch into some hot-off-the-press
> version of the kernel?

As far as I can see GKHI is overkill for dprobes alone, the existing
notifier lists would be sufficient because dprobes does not hook into any 
performance critical paths. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
