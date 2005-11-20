Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVKTXaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVKTXaj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVKTXaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:30:39 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:4366 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932124AbVKTXai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:30:38 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115055107.GB3252@IBM-BWN8ZTBWAO1>
	<20051113152214.GC2193@spitz.ucw.cz>
	<9901B851-17B2-4AEB-813F-A92560DFE289@mac.com>
	<20051116203603.GA12505@elf.ucw.cz>
	<1132174090.5937.14.camel@localhost>
	<20051119233010.GA3361@spitz.ucw.cz>
From: Nix <nix@esperi.org.uk>
X-Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: Sun, 20 Nov 2005 23:29:04 +0000
In-Reply-To: <20051119233010.GA3361@spitz.ucw.cz> (Pavel Machek's message of
 "20 Nov 2005 08:17:48 -0000")
Message-ID: <87veym7vb3.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 2005, Pavel Machek stated:
> Hi!
>> I also hate bloating types and making them sparse just for the hell of
>> it.  It is seriously demoralizing to do a ps and see
>> 7011827128432950176177290 staring back at you. :)
> 
> Well, doing cat /var/something/foo.pid, and seeing pid of unrelated process
> is wrong, too... especially if you try to kill it....

I'd venture to say that anything using multiple pid namespaces should be
mounting its own private /var/run subtree (and similar for other such
directories). Consider it as similar to the problem of colliding PIDs on
multiple physical hosts, or on a host and a pile of UMLs it's running:
the solution there, too, is to unshare /var/run (by not NFS-exporting it
in the latter two cases, by private mounts in the former).

(Isn't this PID namespace stuff meant for chroots anyway?)

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

