Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVGGOE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVGGOE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVGGOBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:01:18 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:7690 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261570AbVGGOAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:00:14 -0400
Message-ID: <42CD3580.4020008@slaphack.com>
Date: Thu, 07 Jul 2005 09:00:32 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
Cc: Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local> <20050629135820.GJ11013@nysv.org> <20050629205636.GN16867@khan.acc.umu.se> <42C4FA1A.1050100@slaphack.com> <20050701155446.GZ16867@khan.acc.umu.se> <20050707082749.GZ11013@nysv.org>
In-Reply-To: <20050707082749.GZ11013@nysv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist wrote:
> On Fri, Jul 01, 2005 at 05:54:46PM +0200, David Weinehall wrote:
> 
>>Which would neither need VFS changes nor be dependent on Reiser4 in
>>any way, so I don't see why this thread lives on.  Just get down to
>>business and implement this metafs =)
> 
> 
> I've been gone for a while and suddenly drowning in mail...
> 
> Anyway, I don't really like the metafs thing.
> 
> To access the data, you still need to refactor userspace,
> so that's not a real advantage. Doing lookups from /meta
> all the time, instead of in the file-as-dir-whatever...

I don't really see the disadvantage.

Also, metafs means much less of a fight to get people to adopt the whole 
meta concept, because it can be done in a POSIX-compliant way which 
doesn't break tar.

File-as-dir is nice if you're using meta files, but it causes lots of 
unexpected weirdness.  I don't think metafs costs us much in 
performance, and with one or two shell scripts, it wouldn't cost us that 
much efficiency on the commandline.

But, I also like file-as-dir.  I think it might be time for a vote.

I vote metafs.

Or, maybe Hans needs to tell us which way we're going...

> And the best thing to do would be to bring these "Reiser4-specific"
> enhancements to every FS.

Which has nothing to do with whether it's done in "metafs" or not.
