Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVAOAYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVAOAYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVAOAYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:24:45 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:4501
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262054AbVAOAYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:24:21 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tim Bird <tim.bird@am.sony.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41E8543A.8050304@am.sony.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>
	 <41E8543A.8050304@am.sony.com>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 01:24:16 +0100
Message-Id: <1105748656.13265.90.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Fri, 2005-01-14 at 15:22 -0800, Tim Bird wrote:
> [ Lots of excellent criticisms omitted.]

Thanks for the compliment :)

> I don't want to be argumentative, but possibly (to answer your last
> question first), there are twofold reasons to put this in -mm:
>  - there's no tracing infrastructure in the kernel now (except for
>  kprobes - which provides hooks for creating tracepoints dynamically,
>  but not 1) supporting infrastructure for timestamping, managing event
>  data, etc., and 2) a static list of generally useful tracepoints.
>  - to generate this discussion.

I have no objection at all to put instrumentation into the kernel. Quite
the contrary, I would appreciate it.

Putting tracepoints into the kernel is great.
Providing a trace/log/instrumentation framework is great.
Adding the given overhead is not.

> I've used it for various tasks, and I know others who have.  I wouldn't
> recommend it in its present form for deep scheduling tweaks or debugging
> kernel race conditions (which it is more likely to mask than
> it is to find), but inapplicability there hardly makes it worthless for
> other things.

Putting a 200k patch into the kernel for limited usage and maybe
restricting a generic simple non intrusive and more generic
implementation by its mere presence is making it inapplicable enough.

Merge the instrumentation points from ltt and other projects like DSKI
and the places where in kernel instrumentation for specific purposes is
already available and use a simple and effective framework which moves
the burden into postprocessing and provides a simple postmortem dump
interface, is the goal IMHO.

When this is available, trace tool developers can concentrate on
postprocessing improvement rather than moving postprocessing
incapabilities into the kernel.

> By the way, don't think that your comments are not appreciated.
> I'm not particularly glued to any specific part of the implementation.
> I'm excited to see tracing discussed here, if only to avoid
> duplicate efforts and point out danger areas, for multiple tracing
> projects that I am aware of.

So I'm I.

tglx


