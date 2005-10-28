Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVJ1WNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVJ1WNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbVJ1WNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:13:51 -0400
Received: from mx1.netapp.com ([216.240.18.38]:782 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1030357AbVJ1WNu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:13:50 -0400
X-IronPort-AV: i="3.97,263,1125903600"; 
   d="scan'208"; a="264937643:sNHT18353748"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Link error in ./net/sunrcp/
Date: Fri, 28 Oct 2005 15:13:49 -0700
Message-ID: <044B81DE141D7443BCE91E8F44B3C1E288E5B8@exsvl02.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Link error in ./net/sunrcp/
Thread-Index: AcXcC8gK2mZkCLMMTCSEI6InBBs/mwAARBmw
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: "Myklebust, Trond" <Trond.Myklebust@netapp.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Oct 2005 22:13:49.0539 (UTC) FILETIME=[DF620B30:01C5DC0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noted.  patch forthcoming.

> -----Original Message-----
> From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de] 
> Sent: Friday, October 28, 2005 6:06 PM
> To: Lever, Charles
> Cc: Myklebust, Trond; linux-kernel@vger.kernel.org
> Subject: Re: Link error in ./net/sunrcp/
> 
> 
> On Fri, 2005-10-28 14:26:11 -0700, Lever, Charles 
> <Charles.Lever@netapp.com> wrote:
> > > I get this link error:
> > > 
> > > net/built-in.o: In function 
> > > `xs_bindresvport':xprtsock.c:(.text+0x46970): undefined 
> > > reference to `xprt_min_resvport'
> > > :xprtsock.c:(.text+0x46978): undefined reference to 
> > > `xprt_max_resvport'
> > > net/built-in.o: In function `xs_setup_udp': undefined 
> > > reference to `xprt_udp_slot_table_entries'
> > > net/built-in.o: In function `xs_setup_tcp': undefined 
> > > reference to `xprt_tcp_slot_table_entries'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > in case of CONFIG_SYSCTL not being enabled. This is on 
> the VAX port,
> > > but I guess it'll show up on any target...
> > 
> > i thought that you couldn't actually get a .config that would build
> > the sunrpc stuff if CONFIG_SYSCTL was disabled.  thus the 
> macro logic
> > in net/sunrpc doesn't check for it.
> > 
> > was i wrong about that?
> 
> I just configured for i386, NFS support compiled in, but "Sysctl
> support" (in "General setup") being switched off:
> 
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `xs_bindresvport':
> : undefined reference to `xprt_max_resvport'
> net/built-in.o: In function `xs_bindresvport':
> : undefined reference to `xprt_min_resvport'
> net/built-in.o: In function `xs_setup_udp':
> : undefined reference to `xprt_udp_slot_table_entries'
> net/built-in.o: In function `xs_setup_udp':
> : undefined reference to `xprt_max_resvport'
> net/built-in.o: In function `xs_setup_tcp':
> : undefined reference to `xprt_tcp_slot_table_entries'
> net/built-in.o: In function `xs_setup_tcp':
> : undefined reference to `xprt_max_resvport'
> net/built-in.o:(__ksymtab+0xfb0): undefined reference to 
> `xprt_udp_slot_table_entries'
> net/built-in.o:(__ksymtab+0xfb8): undefined reference to 
> `xprt_tcp_slot_table_entries'
> make: *** [.tmp_vmlinux1] Error 1
> 
> MfG, JBG
> 
> -- 
> Jan-Benedict Glaw       jbglaw@lug-owl.de    . 
> +49-172-7608481             _ O _
> "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | 
> Gegen Krieg  _ _ O
>  für einen Freien Staat voll Freier Bürger"  | im Internet! | 
>   im Irak!   O O O
> ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | 
> DRM | TCPA));
> 
