Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUHTQ1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUHTQ1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268319AbUHTQY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:24:57 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:5390 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S268314AbUHTQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:24:34 -0400
Date: Fri, 20 Aug 2004 18:23:31 +0200
From: "'DervishD'" <disposable1@telefonica.net>
To: Robert White <rwhite@casabyte.com>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: setproctitle
Message-ID: <20040820162331.GB1238@DervishD>
Mail-Followup-To: Robert White <rwhite@casabyte.com>,
	'William Lee Irwin III' <wli@holomorphy.com>,
	'Linux-kernel' <linux-kernel@vger.kernel.org>
References: <20040818085850.GW11200@holomorphy.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAvgXAGuUD20CaadqFIQ1OWQEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAvgXAGuUD20CaadqFIQ1OWQEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Robert :)

 * Robert White <rwhite@casabyte.com> dixit:
> > The command-line arguments are being fetched from the process address
> > space, i.e. simply editing argv[] in userspace will have the desired
> > effect. Though this code is butt ugly.
[...]
> Can the entirety of arg[] be moved to a newly allocated region, if
> so how?  (e.g. wouldn't I have to have access to overwrite
> mm->arg_start etc?

    That was one of the problems I was having: overwriting the memory
you already have is easy, but moving... I mean, you realloc and move
the memory but the kernel doesn't notice it, am I wrong?
 
> I'd prefer a setthreadtitle(char * new_title) such that the
> individual threads in a process (including the master thread, and
> so setproctitle() function is covered) could be re-titled to
> declare their purposes.  It would make debugging and logging a lot
> easier and/or more meaningful sometimes. 8-)

    Exactly ;)
 
> I'd be willing to work on this if there is interest.

    I'm VERY interested, but the problem is that in any case I won't
be able to use that in my programs since portability is sometimes an
issue :( Not all OS are able of such things. The problem, in the end,
is that changing the name of the process is not a standard thing...

    Thanks for your help :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
