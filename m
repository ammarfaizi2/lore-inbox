Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288837AbSAEPI4>; Sat, 5 Jan 2002 10:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288836AbSAEPIq>; Sat, 5 Jan 2002 10:08:46 -0500
Received: from ns.ithnet.com ([217.64.64.10]:36868 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288834AbSAEPIh>;
	Sat, 5 Jan 2002 10:08:37 -0500
Date: Sat, 5 Jan 2002 16:08:33 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020105160833.0800a182.skraw@ithnet.com>
In-Reply-To: <20020104175050.A3623@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com>
	<200201040019.BAA30736@webserver.ithnet.com>
	<20020103232601.B12884@asooo.flowerfire.com>
	<20020104140321.51cb8bf0.skraw@ithnet.com>
	<20020104175050.A3623@asooo.flowerfire.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 17:50:50 -0600
Ken Brownfield <brownfld@irridia.com> wrote:

> On Fri, Jan 04, 2002 at 02:03:21PM +0100, Stephan von Krawczynski wrote:
> [...]
> | Ok. It would be really nice to know if the -aa patches do any good at your
> 
> I'd love to, but unfortunately my problems reproduce only in production,
> and -- nothing against Andrea -- I'm hesitant to deploy -aa live, since
> it hasn't received the widespread use that mainline has.  I may be
> forced to soon if the VM fixes don't get merged.

I am pretty impressed by Martins test case where merely all VM patches fail
with the exception of his own :-) The thing is, this test is not of nature
"very special" but more like "system driven to limit by normal processes". And
this is the real interesting part about it.

> | Hm, I have about 24GB of NFS traffic every day, which may be too less. What
> | exactly are you seeing in this case (logfiles etc.)?
> 
> Well, the nature of the problem is that the timer "slows" and stops,
> causing the machine to get more and more sluggish until it falls of the
> net and stops dead.
> 
> I suspect that high IRQ rates cause the issue -- large sequential
> transfers are not necessarily culprits due the lowish overhead.

What exactly do you mean with "high IRQ rate"? Can you show so numbers from
/proc/interrupts and uptime for clarification?

> | Hopefully nobody does this here, I don't.
> 
> I don't think it's intentional, and I realize that VM changes are hard
> to swallow in a stable kernel release.  I just hope that the severity
> and fairly wide negative effect is enough to make people more
> comfortable with accepting VM fixes that may be somewhat invasive.

Hm, I don't think real "big" patches are needed, Rik is according to Martins
test no gain currently as rmap flops in this test, too.

The problem is: you should really use one of your problem machines for at least
very simple testing. If you don't you possibly cannot expect your problem to be
solved soon. We would need input from your side. If I were you, I'd start of
with Martins patch. It is simple (very simple indeed), small and pinned to a
single procedure. Martins test shows - under "normal" high load (not especially
IRQ) - good result and no difference in standard load, I cannot see a risk for
oops or deadlock.

Regards,
Stephan


