Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVK2QvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVK2QvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVK2QvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:51:22 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:9477 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932165AbVK2QvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:51:22 -0500
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question: madvise(DONT_SYNC)
References: <200511271925.09565.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: Tue, 29 Nov 2005 16:51:16 +0000
In-Reply-To: <200511271925.09565.rob@landley.net> (Rob Landley's message of
 "28 Nov 2005 01:35:57 -0000")
Message-ID: <87y837s8hn.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 2005, Rob Landley whispered secretively:
> I can change the default to /dev/pts (which is tmpfs with the sticky bit on 
> Fedora Core 4, Ubuntu, and Gentoo.

Um, you mean /dev/shm, right?

>                                     But which has nothing mounted on it and 
> isn't even world writable on the only x86-64 system I currently have access 

Well, shm_open() and friends just won't work on that system (the /dev/shm path
is hardwired into glibc; I guess the PLD people might have hacked glibc to
change that path, but that seems peculiar).

Distro bug.

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

