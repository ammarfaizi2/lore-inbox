Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSF1JQE>; Fri, 28 Jun 2002 05:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317081AbSF1JQD>; Fri, 28 Jun 2002 05:16:03 -0400
Received: from mail2.alphalink.com.au ([202.161.124.58]:15443 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S317073AbSF1JQD>; Fri, 28 Jun 2002 05:16:03 -0400
Message-ID: <3D1C2964.2D245607@alphalink.com.au>
Date: Fri, 28 Jun 2002 19:16:20 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] [PATCH] kconfig: menuconfig and config uses $objtree
References: <934.1025254697@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Fri, 28 Jun 2002 18:07:45 +1000,
> Greg Banks <gnb@alphalink.com.au> wrote:
> >Sam Ravnborg wrote:
> >>
> >> In order to prepare for separate obj and src trees make use of $objtree
> >> within scripts/Menuconfig and scripts/Configure.
> >> All temporary and all result files are located in directory pointed at
> >> by $objtree.
> >
> >Interesting, but there's an alternative approach. [...]
> 
> You are still forcing all the CML code to know about the difference
> between source and object trees and to handle multiple source trees.

Yes.

> With that approach, the knowledge has to be embedded in every CML
> program, and changed every time the tree structure changes.

I haven't commented on whether Sam's patch is good architecture, just
that it could be implemented in several hundred fewer lines.

> It is far better to retain the existing CML design which assumes that
> there is only one tree.  Then use symlinks to hide the real tree
> structure from CML.  That gives us the flexibility to change the tree
> structure without changing every CML program.

Sure.  Assuming Sam's script will take the source director(y|ies) as an
argument, they will work with this approach but they will also work with
whatever approach Kai takes.

> Notice that kbuild 2.5 handles separate source and object trees and
> even multiple source trees with _no_ changes to CML code.  The only
> change to CML in kbuild 2.5 is to add Ghozlane Toumi's extra config
> targets.  scripts/Makefile-2.5 hides all the complexity of separate
> source and object and multiple source trees from both CML1 and CML2.

Great, another reason to use kbuild 2.5.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.	   - Roger Sandall, The Age, 28Sep2001.
