Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbSKUQtJ>; Thu, 21 Nov 2002 11:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSKUQtJ>; Thu, 21 Nov 2002 11:49:09 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:34834 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266868AbSKUQtH>; Thu, 21 Nov 2002 11:49:07 -0500
Date: Thu, 21 Nov 2002 17:55:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: New kconfig: Please add define_*
In-Reply-To: <20021121133320.GD18869@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0211211740130.2113-100000@serv>
References: <20021121133320.GD18869@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Nov 2002, Adrian Bunk wrote:

> one thing that easily leads to errors is that the difference between
> e.g. bool and define_bool is less obvious than before (it's no longer
> explicitely stated). If there's no string behind the bool and no
> "prompt" line it's now treated as define_bool. I've already found two
> places in sound/oss/Kconfig where this was missing accidentially. Could
> you add explicite define_* back to the config language and let the
> program quit with an error if there's e.g. a define_bool with a string
> or prompt line or a bool without a string or prompt line?

It was not missing accidentially, these symbols were defined with 
define_bool before.
I'll think about the define_* syntax, but I will not make the other syntax 
illegal. The current 'bool "prompt"' is already a shortcut for the more 
common requirement:

config FOO
	bool
	prompt '...'

Also note that the role of the default has changed, a default cannot 
override a prompt anymore (it only provides a default value to the 
prompt). The define_* syntax might imply that this is possible, but it 
won't.

bye, Roman

