Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbTGMQal (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTGMQal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:30:41 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5640 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270271AbTGMQaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:30:39 -0400
Date: Sun, 13 Jul 2003 18:45:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Avoiding "unused variable" warnings
In-Reply-To: <1058113342.561.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307131834300.717-100000@serv>
References: <200307131932.24015.arvidjaar@mail.ru>  <3F117EE3.5010200@pobox.com>
 <1058113342.561.0.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13 Jul 2003, Alan Cox wrote:

> > No need for a macro, just do
> > 
> > 	(void) var_name;
> > 
> > It doesn't generate any code, and it shuts up the compiler.
> 
> It may do. The proper gcc thing is attribute unused. Both are dangerous
> as they hide when the variable becomes really unused

Function like macros, which throw away their arguments, can be dangerous. 
I had a funny bug like this:

	kunmap(*pagep++);

bye, Roman

