Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289803AbSBOO2h>; Fri, 15 Feb 2002 09:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289809AbSBOO2R>; Fri, 15 Feb 2002 09:28:17 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:36114 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289803AbSBOO2P>; Fri, 15 Feb 2002 09:28:15 -0500
Date: Fri, 15 Feb 2002 15:28:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <davidm@hpl.hp.com>,
        "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move task_struct allocation to arch 
In-Reply-To: <23760.1013782075@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0202151522550.1145-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Feb 2002, David Howells wrote:

> Should I move the convenience bit operations back to the arch header, so that
> the M68K guys can have byte-sized flags (which they can use TAS/TST on)?

No tas needed, just byte store, so it's not only for m68k, ppc would
benefit from it too and probably some more.

bye, Roman

