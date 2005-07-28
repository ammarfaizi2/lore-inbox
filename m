Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVG1KT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVG1KT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVG1KRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:17:32 -0400
Received: from ns.firmix.at ([62.141.48.66]:48042 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261367AbVG1KQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:16:44 -0400
Subject: Re: [PATCH] signed char fixes for scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42E8AD47.6010501@grupopie.com>
References: <1121465068l.13352l.0l@werewolf.able.es>
	 <1121465683l.13352l.5l@werewolf.able.es>
	 <20050727202757.GB31180@mars.ravnborg.org>
	 <1122507398l.19829l.0l@werewolf.able.es>  <42E8AD47.6010501@grupopie.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 28 Jul 2005 12:16:17 +0200
Message-Id: <1122545777.16156.59.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 11:02 +0100, Paulo Marques wrote:
> J.A. Magallon wrote:
> > On 07.27, Sam Ravnborg wrote:
> >>On Fri, Jul 15, 2005 at 10:14:43PM +0000, J.A. Magallon wrote:
> >>>On 07.16, J.A. Magallon wrote:
> >>>>On 07.15, Andrew Morton wrote:
> >>>>
> >>>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> >>>
> >>>This time I did not break anything... and they shut up gcc4 ;)
                                                            ^^^^
> >>I have applied it to my tree. There still is a lot left when I compile
> >>with -Wsign-compare.
> > 
> > All the problems are born here:
> > 
> > struct sym_entry {
> >     unsigned long long addr;
> >     unsigned int len;
> >     unsigned char *sym;
> > };
> 
> What are you guys talking about?

"unsigned char *" is simply the wrong type for mere text strings. "char
*" ist the corrrect one. These are BTW two completely different types
(yes, "char" can be promoted into an "unsigned char" but essentially
these are two completely different types like "int" and "long long *").

> Is my compiler version the problem (3.3.2), or are you testing with the 

Compiler version - zse gcc-4.*.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

