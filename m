Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSKMS4J>; Wed, 13 Nov 2002 13:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSKMS4J>; Wed, 13 Nov 2002 13:56:09 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:29707 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262803AbSKMS4J>; Wed, 13 Nov 2002 13:56:09 -0500
Date: Wed, 13 Nov 2002 20:02:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and the Interfaces who Love Them (Take I)
In-Reply-To: <20021113101924.104F92C0B0@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211131430190.2109-100000@serv>
References: <20021113101924.104F92C0B0@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 13 Nov 2002, Rusty Russell wrote:

> Feedback appreciated.  It's aimed at driver writers.

If that's your audience, I expect a very confused audience.
You can make it very simple: There are safe interfaces and there are 
broken interfaces and you shall never write or use broken interfaces.
For the majority of driver writers that's good enough.
Any documentation about module writing should also include/point to a 
chapter about resource management. The user has to understand anyway, by 
whom the module resources are used, otherwise he has more problems than 
just module unloading. Module management is just a small part of this 
whole picture or could be part of it, but right now the current module 
code is desperate attempt at keeping it out of it.
I would prefer if the user would be teached about proper resource 
management at kernel level. As soon as the user gets that right he will 
also have no problems to get module unloading right _if_ that would follow 
the same rules, but currently it involves lots of black magic instead.
Rusty, I'm not impressed by the new module code, maybe I'm missing 
something, but it doesn't fix anything and only encourages to write more 
broken interfaces.

bye, Roman


