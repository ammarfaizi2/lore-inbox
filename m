Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWGGQDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWGGQDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWGGQDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:03:20 -0400
Received: from mailhost.terra.es ([213.4.149.12]:35700 "EHLO
	csmtpout1.frontal.correo") by vger.kernel.org with ESMTP
	id S932140AbWGGQDU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:03:20 -0400
Date: Fri, 7 Jul 2006 18:09:39 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: "Avuton Olrich" <avuton@gmail.com>
Cc: jan@rychter.com, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability
Message-Id: <20060707180310.ef7186d7.grundig@teleline.es>
In-Reply-To: <3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com>
References: <200606270147.16501.ncunningham@linuxmail.org>
	<20060627133321.GB3019@elf.ucw.cz>
	<44A14D3D.8060003@wasp.net.au>
	<20060627154130.GA31351@rhlx01.fht-esslingen.de>
	<20060627222234.GP29199@elf.ucw.cz>
	<m2k66qzgri.fsf@tnuctip.rychter.com>
	<3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 7 Jul 2006 08:19:21 -0700,
"Avuton Olrich" <avuton@gmail.com> escribió:

> As I've said in previous threads, I've had a much higher rate of
> sucess with suspend2 than swsusp, much like others who are replying to
> this thread. Can anyone tell me, did Suspend2 get veto'd? If not has
> there been a clear laid-out plan of what needs to be done to get this
> in to the kernel? Is adding new in-kernel suspend code not an option
> now? This is not about eye-candy but simply getting computers to

There's probably a high resistance at doing such thing, and I don't
think suspend2 developers should take it as "discrimination". As I
understand the development in the linux land, I could find the
following reasons for not doing such thing:

2.6 is supposed to be a stable release. There has been many 
"merge $FOO2, because is better than $FOO" experiments in the
past, and they have not been fun, in many cases they have been
_rejected_ even if they worked better. Reason? Regressions.
Mergin One Big Thing (be it splitted in 200 different patches
or not suspend2 it's a One Big Thing) always is painful - the
linux style these days is to "improve" things

As much as people may dislike swsusp, it's merged in the main
tree, and this means it has _lots_ of users, and hence more
probabilities of being tested in machines where it doesn't
works for god-know-what-reason, and more probabilities of
getting hate-mail. Suspend2 may work in many cases where
swsusp does not (for whatever reason), but the contrary 
can be also be true, and "It Works For Me" it's not a good
measure at all for taking such decisions. I bet most of
the non-suspend2/swsusp developers wold rather fix swsusp
rather than replacing it with a "undertested" (it's not in
the main tree) solution.

You may ask "why not merge suspend2", but from an objective
POV it's perfectly fine that some people asks "why don't
suspend2 people try to improve swsusp instead of rewritting
it? It may be easier to fix swsusp than replacint it with
suspend2"

(Personally I don't use suspend2 or swsusp, real men never
switch off their computers)
