Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316778AbSFDU5z>; Tue, 4 Jun 2002 16:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSFDU5y>; Tue, 4 Jun 2002 16:57:54 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:38272
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316778AbSFDU5x>; Tue, 4 Jun 2002 16:57:53 -0400
Date: Tue, 4 Jun 2002 13:56:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mochel@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020604205644.GB1335@opus.bloom.county>
In-Reply-To: <20020604.111337.51699424.davem@redhat.com> <Pine.LNX.4.33.0206041227410.654-100000@geena.pdx.osdl.net> <20020604.124241.78709149.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 12:42:41PM -0700, David S. Miller wrote:
>    From: Patrick Mochel <mochel@osdl.org>
>    Date: Tue, 4 Jun 2002 12:38:06 -0700 (PDT)
> 
>    
>    > There's this middle area between core and subsys, why not
>    > just be explicit about it's existence?
>    > 
>    > Short of making the true dependencies describable, I think my
>    > postcore_initcall solution is fine.
>    
>    What sense is there in naming it postcore_initcall? What does it tell you 
>    about the intent of the function? 
>    
> It says "this has to be initialized, but after core initcalls because
> it expects core to be setup."  That's what "postcore" means. :-)
> 
>    The initcall levels are not a means to bypass true dependency resolution. 
>    They're an alternative means to solving some of the dependency problems 
>    without having a ton of #ifdefs and hardcoded, explicit calls to 
>    initialization routines. 
>    
> I added no ifdefs, what are you talking about.

I think the ifdefs referred to any of the more complex, but also
arguably more correct ideas (ie things which actually do real
dependancies).  Or maybe hard-coding the corner cases and keeping the
current solution.

> You people are blowing this shit WAY out of proportion.  Just fix the
> bug now and reinplement the initcall hierarchy in a seperate changeset
> so people can actually get work done in the 2.5.x tree while you do
> that ok?

heh.  Or implement some sort of proper dependancies to it all as well.
:)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
