Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTLEODM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTLEODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:03:12 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:13234
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S264126AbTLEODH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:03:07 -0500
Date: Fri, 5 Dec 2003 09:03:04 -0500
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031205140304.GF17870@michonline.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312042245350.9125@home.osdl.org> <MDEHLPKNGKAHNMBLJOLKAEJHIHAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEJHIHAA.davids@webmaster.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 03:16:27AM -0800, David Schwartz wrote:
> > The GPL expressly states that the license does not restrict the act of
> > "running the Program" in any way, and yes, in that sense you may "use" the
> > program in whatever way you want.
> 
> 	Please tell me how you use the Linux kernel source code. Please tell me how
> you run the Linux kernel source code without creating a derived work.

You "use" the Linux source code by feeding it to a compiler.  Or maybe
as a hideous fortune file.  The output of that compiler is *clearly* a
derived work, and thus bound by the GPL.

So far, I don't see any reason why a module that uses an inline function
provided via a kernel header could be distributed in binary format without 
being a "derived work" and thus bound by the GPL.

[snipping a bit]

> > In fact, it very much says the reverse. If you use the source code to
> > build a new program, the GPL _explicitly_ says that that new program has
> > to be GPL'd too.
> 
> 	I download the Linux kernel sources from kernel.org. Please tell me what I
> can do with them without agreeing to the GPL. Is it your position that I
> cannot compile them without agreeing to the GPL? If so, how can running the
> program be unrestricted? How can you run the linux kernel soruce code
> without compiling it?

Compile it.
Run the resulting executable (ignoring the case law that says copying
into ram is a copy under copyright law)
Read the source code.
Write a module using the source code (i.e, via headers)

If you want to distribute that module, you must, of course, follow the
GPL.

> 	You run a piece of source code by compiling it. If a header file is
> protected by the GPL, permission to "run" it means permission to include it
> in files you compile.

You don't run source code.  Not even in Perl programs (though there, at
least, the distinction is more complicated.)

You compile source code.  The resultant object code is then run.

> > In short: you do _NOT_ have the right to use a kernel header file (or any
> > other part of the kernel sources), unless that use results in a GPL'd
> > program.
> 
> 	The phrase "results in a GPL'd program" is one that I cannot understand. I
> have no idea what you mean by it. You have the right to "run" the header
> file, the GPL gives it to you. The way you "run" a header file is by first
> compiling a source code that includes it into an executable.

Repeat after me: The GPL is a copyright license.  It covers
distribution, not use.  Distribution of any part of the "work" is
covered.  Inline functions in headers are clearly part of the "work".

If you have a module that uses an inline function, there are two
options (note: not two legal options):
	Distribute source
	Distribute a binary

If you distribute a binary and refuse to provide the source under the GPL, 
ask yourself this: What gave you the right to distribute the
compiled form of the inline functions you use?

Note: My use of "inline functions" as a bludgeoning device should not be
interpreted as an acknowledgement that the rest of the header files
constitute a published "API".

-- 

Ryan Anderson
  sometimes Pug Majere
