Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264409AbRFIREc>; Sat, 9 Jun 2001 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263597AbRFIREW>; Sat, 9 Jun 2001 13:04:22 -0400
Received: from HSE-MTL-ppp72639.qc.sympatico.ca ([64.229.201.194]:51328 "HELO
	oscar.casa.dyndns.org") by vger.kernel.org with SMTP
	id <S264409AbRFIREM>; Sat, 9 Jun 2001 13:04:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Wayne Whitney <whitney@math.berkeley.edu>, kaos@ocs.com.au,
        Ed Tomlinson <tomlins@cam.org>
Subject: Re: missing symbol do_softirq in net moduels for pre-2
Date: Sat, 9 Jun 2001 13:04:10 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01060911075200.00993@oscar> <16339.992103452@ocs4.ocs-net> <200106091656.f59Gurx10167@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
In-Reply-To: <200106091656.f59Gurx10167@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
MIME-Version: 1.0
Message-Id: <01060913041000.01756@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 June 2001 12:56, Wayne Whitney wrote:
> In mailing-lists.linux-kernel, Keith Owens wrote:
> > On Sat, 9 Jun 2001 Ed Tomlinson <tomlins@cam.org> wrote:
> > > Built -pre2 and noticed most of the modules in net/* are getting
> > > a missing symbol for do_softirq.
> >
> > http://www.tux.org/lkml/#s8-8
>
> Hmm, I don't think this is it--I'm seeing the same thing, and I have
> tried 'make mrproper'.  All symbols are getting versionated except
> certain calls to do_softirq() in, e.g., sunrpc.o and the iptables
> modules.
>
> I looked into this, and I believe the problem is due to 2.4.6-pre2's
> change to the i386 local_bh_enable() macro--the C version has been
> replaced with an assembly language version that does "call
> do_doftirq;".  Perhaps this function call from the assembly language
> version does not get versionated?

In my case its off a clean tree patched with lvm, ide patches, dma timeout
retry patch and reiserfs fixes.  Did we not have a problem a while back
in ac with versioned symbols in assembly?

Ed Tomlinson
