Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbSKCTKw>; Sun, 3 Nov 2002 14:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSKCTKw>; Sun, 3 Nov 2002 14:10:52 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:9859 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262344AbSKCTKv>; Sun, 3 Nov 2002 14:10:51 -0500
Date: Sun, 3 Nov 2002 13:17:22 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "David S. Miller" <davem@redhat.com>
cc: Matthew Wilcox <willy@debian.org>, Pete Zaitcev <zaitcev@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: invalid character 45 in exportstr for include-config
In-Reply-To: <1036304411.17126.1.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0211031314290.17026-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2002, David S. Miller wrote:

> On Sat, 2002-11-02 at 19:18, Matthew Wilcox wrote:
> > Anyone else seeing this error message?  I figured out what it _actually_
> > means is that the character `-' is not permitted in the symbol being
> > exported.  so if we change include-config to include_config in Makefile
> > and scripts/Makefile.build, everything is fine.
> > 
> > How about the following patch?
> 
> Nice work Matthew, although you missed cleaning up a few remaining
> 'include-config' references in comments.
> 
> Kai, this fixes the problem I reported to you on sparc64 with
> make-3.79   What version of make do you have which accepted this
> variable name with a dash in it?

Thank you guys, I'll push it to Linus if it's not merged already. As 
other people pointed out, it seems to be that various version of bash/sh 
seem to handle the '-' differently.

Makes me wonder if Pete's exporting of 'INIT-Y' is a good idea, you may 
want to change that to '_' as well.

--Kai




