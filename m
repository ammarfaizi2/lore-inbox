Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUHMLHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUHMLHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUHMLHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:07:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60349 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262006AbUHMLHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:07:04 -0400
Date: Fri, 13 Aug 2004 13:06:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
In-Reply-To: <20040813105412.GW13377@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0408131259320.20634@scrub.home>
References: <20040813101717.GS13377@fs.tum.de> <Pine.LNX.4.58.0408131231480.20635@scrub.home>
 <20040813105412.GW13377@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Aug 2004, Adrian Bunk wrote:

> > On Fri, 13 Aug 2004, Adrian Bunk wrote:
> > 
> > >  config W1
> > >  	tristate "Dallas's 1-wire support"
> > > +	select NET
> > 
> > What's wrong with a simple dependency?
> 
> it's common practice to make it easier for people configuring the kernel 
> to use select instead of depends in such cases.

select is the wrong tool for this. NET is usually enabled anyway, 
selecting it has no real advantage.
Please use normal dependency whereever possible and use select in such 
cases only as exception and with very good reason. Making kernel 
configuration easier for aunt Tillie is not such reason.

bye, Roman
