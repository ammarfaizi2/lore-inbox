Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSBEDHJ>; Mon, 4 Feb 2002 22:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSBEDGw>; Mon, 4 Feb 2002 22:06:52 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:12747 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S287684AbSBEDGl>;
	Mon, 4 Feb 2002 22:06:41 -0500
Date: Mon, 4 Feb 2002 22:06:28 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Griffiths <andrewg@tasmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace allows you to read -r files
Message-ID: <20020204220628.A2229@nevyn.them.org>
Mail-Followup-To: Andrew Griffiths <andrewg@tasmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202050033.g150XVn17613@picton-ext.nt.tas.gov.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202050033.g150XVn17613@picton-ext.nt.tas.gov.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 11:33:32AM +1100, Andrew Griffiths wrote:
> Hello everyone,
> 
> While playing around I noticed that if I fork()ed, then did ptrace(PTRACE_TRACEME,...) then exec'd a non-readable binary, the ptrace interface would let me read the binary.
> 
> This was tested on 2.4.17ctx-5 (the security context patch), however I have been told it works on vanilla kernels, also I tested it on 2.4.2-pax on an old machine. (pentium 75...)
> 
> For those who want some demo code, you can find it at http://203.39.161.186/readbin.tgz.
> 
> For testing it, I used /usr/bin/ssh which was rws--x--x.
> 
> Since I'm not subscribed to this list, could any replies be cc'd to me? Thanks.

I think this is just 'known'.  Note that it isn't a security problem
otherwise; you'll find that the setuid application does not setuid if
it is ptraced.  On 2.4.17 at least.


-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
