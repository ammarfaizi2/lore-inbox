Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVKVJA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVKVJA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVKVJA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:00:58 -0500
Received: from main.gmane.org ([80.91.229.2]:42172 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751059AbVKVJA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:00:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Tue, 22 Nov 2005 09:57:43 +0100
Organization: Denizens oak Donuts
Message-ID: <871x19giuw.fsf@obelix.mork.no>
References: <87zmoa0yv5.fsf@obelix.mork.no>
	<d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com>
	<20051119234850.GC1952@spitz.ucw.cz>
	<200511220026.55589.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 139.249.120.148.in-addr.arpa
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:N2WkxaJHDblMCV+O/A+OYH7w0Ic=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> writes:

> Swsusp: do not time-out when stopping tasks while resuming
>
> When stopping tasks during esume process there is no point of
> eastablishing a timeout because teh process is past the point
> of no return; there is no possible recovery from failure. If
> stopping tasks fails resume is aborted and user is forced to
> do fsck anyway.

If a clueless users voice counts for anything: I couldn't agree more.  

A failed resume is a near catastrophy if you use and trust swsusp. And
how could it ever be useful if you don't?

I would much prefer a very long (indefinite) timeout, and to manually
have to force a reboot without resume.  This is an absolutely last
resort and there is no need whatsoever to automatically go there.
Maybe that even would give me a chance to fix some hardware problem
causing the timeout, and then retry the resume.

Please do everything possible to ensure that a resume will never fail
unnecessarily.  I can't see how some arbitrary timeout could be
necessary. 

Just my 2 øre.


Bjørn
-- 
Cardboard cut-outs are fun, huh?  So, a short man ain't got nothing in
the world these days?

