Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTBOUr4>; Sat, 15 Feb 2003 15:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTBOUr4>; Sat, 15 Feb 2003 15:47:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27145 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265169AbTBOUrz>; Sat, 15 Feb 2003 15:47:55 -0500
Date: Sat, 15 Feb 2003 12:53:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dominik Brodowski <linux@brodo.de>
cc: davej@suse.de, <linux-kernel@vger.kernel.org>, <cpufreq@www.linux.org.uk>,
       <zippel@linux-m68k.org>
Subject: Re: [PATCH UPDATED] cpufreq: move frequency table helpers to extra
 module
In-Reply-To: <20030213111406.GA23909@brodo.de>
Message-ID: <Pine.LNX.4.44.0302151252110.21697-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dominic,
 this broke ACPI. 

	In file included from drivers/acpi/processor.c:49:
	include/acpi/processor.h:78: field `freq_table' has incomplete type

AGAIN.

For about the 15th time. 

You guys need to talk more. A LOT more. Or y ou need to start checking who 
is actually _using_ the frequency code, and when you make changes to the 
interfaces you need to _update_ the users, instead of just causing kernel 
compiles to fail every frigging time you make a change.

		Linus

