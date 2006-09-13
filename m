Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIMLIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIMLIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 07:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWIMLIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 07:08:31 -0400
Received: from albireo.ucw.cz ([84.242.87.5]:30481 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1750783AbWIMLIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 07:08:30 -0400
Date: Wed, 13 Sep 2006 12:45:52 +0200
From: Martin Mares <mj@ucw.cz>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: R: Linux kernel source archive vulnerable
Message-ID: <mj+md-20060913.103931.6418.albireo@ucw.cz>
References: <20060907182304.GA10686@danisch.de> <20060913043319.GH541@1wt.eu> <ee8589$e70$1@taverner.cs.berkeley.edu> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com> <ee88af$fgo$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee88af$fgo$1@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> In any case, regardless of whether this is by design or not, it is not
> courteous to your users to distribute tar files where all the files have
> permissions 0666.  That's not a user-friendly to do.

I disagree.

(1) Some systems use per-user groups and create all files group-writeable
by default, i.e., they set the umask to 002. If you want to be user-friendly,
you should respect this setting, so the permissions in the tar archives you
distribute should be 666.

(2) People extracting random archives as root with preserving permissions
(and owners) are relying on *ALL* archive creators using what they suppose
are the right permissions, which is at least simple-minded, if not completely
silly. If you want to help such users, you should do so by helping them
understand they do a wrong thing and not by hiding the problem in a single
specific case.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
First law of socio-genetics: Celibacy is not hereditary.
