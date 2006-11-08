Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWKHUW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWKHUW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWKHUW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:22:28 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:54389
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1422848AbWKHUW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:22:27 -0500
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Miguel Ojeda'" <maxextreme@gmail.com>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How to compile module params into kernel?
Date: Wed, 8 Nov 2006 21:22:24 +0100
Message-ID: <030b01c70373$9a46ebd0$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccDcsws6UOzPNrZS3al8PnYIxyajwAAH6Ig
In-Reply-To: <653402b90611081216o640b1499u8c758775c1cceb51@mail.gmail.com>
X-OriginalArrivalTime: 08 Nov 2006 20:22:25.0560 (UTC) FILETIME=[9ABDC980:01C70373]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Miguel Ojeda [mailto:maxextreme@gmail.com] 
> Sent: den 8 november 2006 21:17
> To: Jesper Juhl
> Cc: Joakim Tjernlund; linux-kernel@vger.kernel.org
> Subject: Re: How to compile module params into kernel?
> 
> On 11/8/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > > -----Original Message-----
> > > > From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> > > >
> > > > On 08/11/06, Joakim Tjernlund 
> <joakim.tjernlund@transmode.se> wrote:
> > > > > Instead of passing a module param on the cmdline I want to
> > > > compile that
> > > > > into
> > > > > the kernel, but I can't figure out how.
> > > > >
> > > > > The module param I want compile into kernel is
> > > > > rtc-ds1307.force=0,0x68
> > > > >
> > > > > This is for an embeddet target that doesn't have 
> loadable module
> > > > > support.
> > > > >
> > > > You could edit the module source and hardcode default values.
> > > >
> > >
> > > Yes, but I don't want to do that since it makes maintance
> > > harder.
> > >
> > Well, as far as I know, there's no way to specify default module
> > options at compile time. The defaults are set in the module 
> source and
> > are modifiable at module load time or by setting options on 
> the kernel
> > command line at boot tiem. So, if that's no good for you I don't see
> > any other way except modifying the source to hardcode new defaults.
> >
> 
> You can add parameter values at Kconfig using "int", "hex"... instead
> of tristate, and then do something like:
> 
> static unsigned int foo = CONFIG_foo;
> module_param(foo, uint, S_IRUGO);
> MODULE_PARM_DESC(foo, "foo value (uint)");

hmm, don't quite understand.
Can you rewrite that to match the cmdvar "rtc-ds1307.force=0,0x68" ? 

