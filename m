Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSHBMiS>; Fri, 2 Aug 2002 08:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSHBMiS>; Fri, 2 Aug 2002 08:38:18 -0400
Received: from pc2-oxfd3-5-cust41.oxf.cable.ntl.com ([213.107.67.41]:32267
	"EHLO noetbook.telent.net") by vger.kernel.org with ESMTP
	id <S313070AbSHBMiP>; Fri, 2 Aug 2002 08:38:15 -0400
To: Camm Maguire <camm@enhanced.com>,
       debian-alpha <debian-alpha@lists.debian.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SA_SIGINFO in Linux 2.4.x
References: <E17aOg0-0002ub-00@intech19.enhanced.com>
	<1028281936.17352.42.camel@satan.xko.dec.com>
From: Daniel Barlow <dan@telent.net>
Date: Fri, 02 Aug 2002 13:41:35 +0100
In-Reply-To: <1028281936.17352.42.camel@satan.xko.dec.com> ("Aneesh Kumar
 K.V"'s message of "02 Aug 2002 15:22:16 +0530")
Message-ID: <87k7n9l9fk.fsf@noetbook.telent.net>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2002-08-02 at 04:14, Camm Maguire wrote:
> Greetings!  The 2.4.x kernels on alpha don't appear to be filling in
> the si_addr element of the siginfo_t structure when a signal handler
> is setup with SA_SIGINFO.  Is this right?  Any other way to get this
> address in the handler?

You may be able to use the third argument to the signal handler:
given a handler declared as (int n, siginfo_t *info,struct ucontext *context),
look at context->uc_mcontext.sc_traparg_a0 

SBCL has been doing this for a few months now and nobody has yet
complained that it's broken for them.  Look for arch_get_bad_addr 
in http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/sbcl/sbcl/src/runtime/alpha-arch.c?rev=1.14&content-type=text/vnd.viewcvs-markup



-dan

-- 

  http://ww.telent.net/cliki/ - Link farm for free CL-on-Unix resources 
