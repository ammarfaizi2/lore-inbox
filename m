Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUHZEQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUHZEQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUHZEQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:16:49 -0400
Received: from lakermmtao06.cox.net ([68.230.240.33]:38332 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S267388AbUHZEQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:16:47 -0400
In-Reply-To: <20040825180615.Z1973@build.pdx.osdl.net>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com> <EAB989A6-F6F9-11D8-A7C9-000393ACC76E@mac.com> <20040825180615.Z1973@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BCE1F8F8-F716-11D8-A7C9-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
       Tim Hockin <thockin@hockin.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Date: Thu, 26 Aug 2004 00:16:43 -0400
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 25, 2004, at 21:06, Chris Wright wrote:
> * Kyle Moffett (mrmacman_g4@mac.com) wrote:
>> I would find this much more useful if there was a really lightweight
>> bind
>> mount called a "filebind" or somesuch that could only bindmount files
> This already works.
>
> # cd /tmp
> # echo foo > a
> # touch b
> # mount --bind a b
> # cat b
> foo

I'm well aware of the technique, but I was wondering if there was any
extra VFS baggage associated with a normal bind mount that might
be eliminated by restricting a different version of a bind mount to only
files.  That's why I asked later if anybody had benchmarked the bind
mount system to see how well it would scale to 1000 bound files and
directories.  If it's not a performance issue then I really don't care 
less,
but I have a somewhat old box that must make do as a fileserver, so
I'm very interested in maximizing the performance. I don't care much
about extra RAM consumption, only about CPU and bus usage.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


