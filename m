Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935864AbWK1LTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935864AbWK1LTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 06:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935865AbWK1LTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 06:19:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28624 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S935864AbWK1LTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 06:19:32 -0500
Date: Tue, 28 Nov 2006 12:19:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Lukasz Stelmach <stlman@poczta.fm>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: autoconf.h and auto.conf missing
In-Reply-To: <456B6B02.9060105@poczta.fm>
Message-ID: <Pine.LNX.4.64.0611281212470.6243@scrub.home>
References: <456B6B02.9060105@poczta.fm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 Nov 2006, Lukasz Stelmach wrote:

> Greetings.
> 
> It seems that someone has broken *conf programs in 2.6.18 because

Unmodified 2.6.18?

> only "make silentoldconfig" recreates autoconf.h and auto.conf
> properly after configuration (.config) has changed.

That's correct. The other config targets only touch the .config file and a 
dependency on it regenerates all other build relevant files (by calling 
silentoldconfig).

> I do everything as I always have done.
> 1. create an empty dir and put my current .config there
> 2. make O=dir oldconfig
> 3. compile, everything seems to be OK here
> 4. do some changes to .config and make oldconfig once again
> BZZZZZT
> 5. auto.conf and autoconf.h don't change along with .config and when
>  I build the kernel once again new settings don't take effect.
> 
> I discovered I have to make silentoldconfig to regenerate autoconf
> files. However, this *seems* to force rebuilding of all the objects
> instead of, what it has always done, only those that depend on
> altered configurations.

I cannot reproduce this, you have to provide some more detailed 
information, e.g. please send your original .config and what exactly you 
changed there.

bye, Roman
