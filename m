Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263384AbUJ2PiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbUJ2PiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbUJ2PgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:36:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7429 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263423AbUJ2PLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:11:41 -0400
Date: Fri, 29 Oct 2004 17:11:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "H. Peter Anvin" <hpa@zytor.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
Message-ID: <20041029151110.GP6677@stusta.de>
References: <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <417FF43C.5050208@tmr.com> <20041029145111.GO6677@stusta.de> <Pine.GSO.4.61.0410291653170.23014@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410291653170.23014@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 04:54:42PM +0200, Geert Uytterhoeven wrote:
> On Fri, 29 Oct 2004, Adrian Bunk wrote:
> > 
> > Read-only /usr is required according to the FHS, and at least on Debian 
> > a read-only /usr works without problems.
> 
> Indeed. And that's what I use. In /etc/apt/apt.conf I have:
> 
>     DPkg {
>         // Auto re-mounting of a readonly /usr
> 	Pre-Invoke {"mount -o remount,rw /usr";};
> 	Post-Invoke {"mount -o remount,ro /usr";};
>     }
> 
> > A bigger problem might be to properly support it in the package manager.
> 
> Yep. Apt knows about it, but dpkg doesn't. And remounting /usr read-only
> fails if files are in use.

I was more thinking about the problems like a database upgrade requiring 
changes to e.g. the system tables of the database handled in the 
{pre,post}inst scripts. It even becomes more tricky since a postinst 
script might make changes to both /usr and such required actions.

These issues which require auditing of all packages are the real issue.

> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

