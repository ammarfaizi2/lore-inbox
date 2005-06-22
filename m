Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVFVOyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVFVOyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFVOoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:44:19 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:45228 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261504AbVFVOlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:41:20 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: -mm -> 2.6.13 merge status
To: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 22 Jun 2005 16:40:16 +0200
References: <4hNoW-1yo-37@gated-at.bofh.it> <4hT1h-5V0-41@gated-at.bofh.it> <4hXHv-1br-41@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Dl6Op-0001qe-Qe@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC Linus, Jesper Juhl (who's currently doing some cleanups)

Andrew Morton <akpm@osdl.org> wrote:

> *general sigh*.  I wish people would absorb CodingStyle.  It's not hard,
> and fixing the style post-facto creates a real mess.  I now have a great
> string of kexec patches followed by a "kexec-code-cleanup.patch" which
> totally buggers up the patch sequencing and really needs to be split into
> 18 parts and sprinkled back over the entire series.

I scripted an automatic whitespace cleanup, which resuled in a fat
patchbomb (about 18 MB, split into > 3600 files (because that way, some
patches are going to apply cleanly)). Obviously applying that would increase
the patch size for the next version by 100%, so that won't be the way to go.
(If you still want to look, see
 http://7eggert.dyndns.org/l/patches/trailing-ws/)

Therefore I suggest that I will
 - make a script that will take a patch, apply it and cleanup the patched
   files as far as a simple script can do the job, so each patched file
   will be ws-clean and the amount of patches will still stay low.
 - a second script that will do some cleanup while the resulting patch is
   less than an annoying amount of KB, so you can cleanup some files that
   wouldn't get patched otherwise.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
