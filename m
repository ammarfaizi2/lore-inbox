Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJYNYD>; Thu, 25 Oct 2001 09:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273831AbRJYNXy>; Thu, 25 Oct 2001 09:23:54 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:33172 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S273796AbRJYNXl>; Thu, 25 Oct 2001 09:23:41 -0400
From: Christoph Rohland <cr@sap.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Andre Margis <andre@sam.com.br>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
In-Reply-To: <Pine.LNX.4.21.0110241509250.885-100000@freak.distro.conectiva> <9r73pv$8h1$1@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 25 Oct 2001 15:23:03 +0200
In-Reply-To: <Pine.LNX.4.21.0110241509250.885-100000@freak.distro.conectiva>
Message-ID: <m3lmhz26rs.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Wed, 24 Oct 2001, Marcelo Tosatti wrote:
> Remember: Everything copied to tmpfs will be kept in memory, so if
> you simply copy way too much data to tmpfs thats your problem :)

Nope, it will swap it out.

On Wed, 24 Oct 2001, Linus Torvalds wrote:
> Ok, the problem appears to be that tmpfs stuff just stays on the
> inactive list, and because it cannot be written out it eventually
> totally clogs the system.
> 
> Suggested fix appended (from Andrea),

> --- v2.4.13/linux/fs/ramfs/inode.c	Tue Oct  9 17:06:53 2001
> +++ linux/fs/ramfs/inode.c	Wed Oct 24 08:59:21 2001

tmpfs != ramfs. So either the patch is not complete or fixes another
problem...

Greetings
		Christoph


