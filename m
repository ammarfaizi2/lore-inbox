Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVLTPmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVLTPmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVLTPmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:42:23 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:14607 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751100AbVLTPmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:42:23 -0500
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as
 non-root
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de>
From: Nix <nix@esperi.org.uk>
X-Emacs: more than just a Lisp interpreter, a text editor as well!
Date: Tue, 20 Dec 2005 15:41:04 +0000
In-Reply-To: <20051219071959.GJ13985@lug-owl.de> (Jan-Benedict Glaw's
 message of "19 Dec 2005 07:21:23 -0000")
Message-ID: <87d5jru67j.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec 2005, Jan-Benedict Glaw stated:
> I've not really used out-of-tree building for Linux, so the tar*
> targets are probably not really tested with that regard. Though I'll
> check that and see if it works (of if a patch is needed.)

Given the existence of `cp -al', I'm not quite sure what the point of
out-of-tree building *is*. (I'm equally mystified by srcdir!=objdir
builds; I can see their utility for software with many generated files
and multi-stage bootstraps, like GCC, 'cos they simplify the makefiles,
but for normal software? What's the point?)

I mean, instead of

cd linux-2.6.blah
make blah O=/some/directory

you can always do

cp -al linux-2.6.blah /some/directory/
cd /some/directory
make blah

unless you're so short of space that you can't store the object files
and the source files on the same disk, and that should be a *very* rare
complaint with today's disk sizes.

-- 
`I must caution that dipping fingers into molten lead
 presents several serious dangers.' --- Jearl Walker
