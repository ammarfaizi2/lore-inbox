Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbVKWKQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbVKWKQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKWKQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:16:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:61122 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030382AbVKWKQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:16:40 -0500
Message-ID: <4384417B.9040201@colitti.com>
Date: Wed, 23 Nov 2005 11:16:27 +0100
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Nigel Cunningham <ncunningham@cyclades.com>, Greg KH <greg@kroah.com>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz> <1132115730.2499.37.camel@localhost> <20051116061459.GA31181@kroah.com> <1132120845.25230.13.camel@localhost> <20051116165023.GB5630@kroah.com> <1132171051.25230.53.camel@localhost> <20051116213517.GD12505@elf.ucw.cz> <1132175248.25230.104.camel@localhost> <20051116224728.GI12505@elf.ucw.cz>
In-Reply-To: <20051116224728.GI12505@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:d113ea4d80cc67690fe2d9dbc522612b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Yes, hopefully users will not notice.

? So the idea is to merge inferior code and "hope users won't notice"?

Users  might not notice that half their memory is gone, but they *will* 
notice that their system is dog slow when it resumes because all their 
caches are gone and a most of their stuff is swapped out.

Non-responsive system on resume is one of the main reasons that swsusp2 
is much better than swsusp1, and yes, users *do* notice (I was one of 
them, as I pointed out a while back). Yes, 50% is better than nothing, 
but it's still a pretty poor show.

Seen from the perspective of a user, the situation is simple: suspend2 
works, it's fast, and it's rock-solid. Just use it.


Regards,
Lorenzo

P.S. Don't "show me the code" me. I can't write the code. :-) But based 
on what I see of how well suspend2 works, I think Nigel can...
