Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUIQQDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUIQQDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269012AbUIQQDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:03:02 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59287 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268995AbUIQP7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:59:51 -0400
Date: Fri, 17 Sep 2004 17:59:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Yuval Turgeman <yuvalt@gmail.com>
cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
In-Reply-To: <9ae345c004091415197ea06621@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0409171752540.877@scrub.home>
References: <20040914121401.GA13531@aduva.com>  <Pine.LNX.4.61.0409141613050.877@scrub.home>
 <9ae345c004091415197ea06621@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 15 Sep 2004, Yuval Turgeman wrote:

> > This still prints duplicate information, look at how
> > ConfigMainWindow::setHelp() in qconf.cc does it. Your function should have
> > pretty much the same structure, e.g.
> 
> I don't understand - duplicate information of what ?
> Can you perhaps give me an example (it seems to me that i am actually
> doing what qconf is doing... printing all the P_SELECT of the all the
> properties, printing the dependencies and the reverse dependencies) ?

try the following:

config FOO
	bool "foo1"
	select BAR

config FOO
	bool "foo2"

config BAR
	bool "bar"

> > here you should iterate over all properties and print the info about it.
> 
> The search prints out plenty of info already - what info do you think
> is missing ?

defaults are missing. Don't concentrate too much on the menu structure 
(it's only relevant for the prompts), if you want to print information 
about a symbol, you have to primarily work with the properties.

bye, Roman
