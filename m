Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTLLWyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTLLWyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:54:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18892 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262331AbTLLWx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:53:58 -0500
Date: Fri, 12 Dec 2003 23:53:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
       linux-tr@linuxtr.net, jschlst@samba.org, cgoos@syskonnect.de,
       mid@auk.cx, jochen@scram.de
Subject: Re: [PATCH][TRIVIAL] dep_tristate wants 3 arguments (fwd)
Message-ID: <20031212225343.GI1825@fs.tum.de>
References: <20031212222655.GH1825@fs.tum.de> <3FDA426B.1060508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDA426B.1060508@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 05:34:19PM -0500, Jeff Garzik wrote:
>...
> >--- linux-5110/drivers/net/tokenring/Config.in
> >+++ linux-10010/drivers/net/tokenring/Config.in
> >@@ -21,10 +21,10 @@ if [ "$CONFIG_TR" != "n" ]; then
> >    dep_tristate '  3Com 3C359 Token Link Velocity XL adapter support' 
> >    CONFIG_3C359 $CONFIG_TR $CONFIG_PCI
> >    tristate '  Generic TMS380 Token Ring ISA/PCI adapter support' 
> >    CONFIG_TMS380TR
> >    if [ "$CONFIG_TMS380TR" != "n" ]; then
> >-      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI 
> >$CONFIG_PCI
> >-      dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA 
> >$CONFIG_ISA
> >-      dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS 
> >$CONFIG_PCI
> >-      dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' 
> >CONFIG_MADGEMC $CONFIG_MCA
> >+      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI 
> >$CONFIG_PCI $CONFIG_TMS380TR
>...
> dep_tristate statements with only three arguments (include desc. text) 
> are just fine.  There is no need for additional arguments.
> 
> 	dep_tristate 'blah blah' CONFIG_BLAH dep...
> 
> Further, adding CONFIG_TMS380TR dependency is complete nonsense, 
> considering that the "if [ "$CONFIG_TMS380TR" != "n" ]" check remains.

Consider:
  CONFIG_TMS380TR=m

E.g. CONFIG_TMSPCI=y shouldn't be allowed in this case.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

