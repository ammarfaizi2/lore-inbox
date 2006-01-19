Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWASBkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWASBkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWASBkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:40:41 -0500
Received: from spooner.celestial.com ([192.136.111.35]:16009 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030341AbWASBkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:40:40 -0500
Date: Wed, 18 Jan 2006 20:40:44 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060119014044.GC17917@kurtwerks.com>
Mail-Followup-To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org> <20060118100133.GE6980@kurtwerks.com> <43CEAEE0.2060109@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CEAEE0.2060109@eyal.emu.id.au>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 08:10:56AM +1100, Eyal Lebedinsky took 0 lines to write:
> Kurt Wall wrote:
> > Seems to be okay here with both gcc 3.4.4 and gcc 4.0.2:
> 
> You must run as root to see it.

Eew. Yes, with root, I get it with both compilers:

root@luther:~# ls -l /dev/null
crw-rw-rw-  1 root sys 1, 3 1994-07-17 19:46 /dev/null
root@luther:~# echo "main() {}" | gcc -xc - -o /dev/null
root@luther:~# ls -l /dev/null
crwxrwxrwx  1 root sys 1, 3 1994-07-17 19:46 /dev/null

root@luther:~# ls -l /dev/null
crw-rw-rw-  1 root sys 1, 3 1994-07-17 19:46 /dev/null
root@luther:~# echo "main() {}" | /usr/local/gcc4/bin/gcc -xc - -o
/dev/null
root@luther:~# ls -l /dev/null
crwxrwxrwx  1 root sys 1, 3 1994-07-17 19:46 /dev/null

Obviously gcc shouldn't do such at thing, but just as obviously, don't
build the kernel as root.

Kurt
-- 
"Right now I'm having amnesia and deja vu at the same time."
	-- Steven Wright
