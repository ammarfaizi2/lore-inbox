Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbTATBfP>; Sun, 19 Jan 2003 20:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTATBfP>; Sun, 19 Jan 2003 20:35:15 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:58241 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267673AbTATBfO>; Sun, 19 Jan 2003 20:35:14 -0500
Date: Sun, 19 Jan 2003 23:44:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: Code obfuscation in acpi
In-Reply-To: <20030118213134.GA8968@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50L.0301192333100.18171-100000@imladris.surriel.com>
References: <20030118213134.GA8968@elf.ucw.cz>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003, Pavel Machek wrote:

> #define acpi_driver_data(d)     ((d)->driver_data)
>
> ... very nice for obfuscating code ...

This is usually called "abstraction" and allows you to change
the data structures (when needed) without breaking all the code.

You can learn from this.  If swsusp used abstractions it wouldn't
need to have to stick its nose into the code and data structures
from other subsystems and it might even stop breaking every other
release.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
