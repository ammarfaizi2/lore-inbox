Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933363AbWKNKFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363AbWKNKFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 05:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933362AbWKNKFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 05:05:55 -0500
Received: from raven.upol.cz ([158.194.120.4]:40359 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S933363AbWKNKFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 05:05:54 -0500
To: Martin Braun <mbraun@uni-hd.de>, David Chinner <dgc@sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
X-Posted-To: gmane.test
Subject: Re: xfs kernel BUG again in 2.6.17.11
References: <44E1D9CA.30805@uni-hd.de> <20060816101122.E2740551@wobbly.melbourne.sgi.com> <44EB228F.6020903@uni-hd.de> <20060823134211.E2968256@wobbly.melbourne.sgi.com> <45583ABE.6080909@uni-hd.de> <20061114040053.GD8394166@melbourne.sgi.com> <45598B07.6080401@uni-hd.de>
Organization: Palacky University in Olomouc, experimental physics department.
Date: Tue, 14 Nov 2006 10:12:19 +0000
Message-ID: <slrnelj5k3.7lr.olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo.

On 2006-11-14, Martin Braun wrote:
> Hi David,
>
>
>> Have you managed to repair the filesystem since you first
>> reported this problem? I don't know the history of the bug

[Well. Just to help (probably) new developers, after Nathan left SGI.]

Here's FAQ node about bug:
http://oss.sgi.com/projects/xfs/faq.html#dir2

You can find fixes in .17 stable git tree.
If it was really just sparse annotations, they were obviously
fixed, i think. If not, meybe there are some new bugs.

> that's something I am not sure about, I have used the newest xfs_repair
> tools and it found and repaired some inodes. And for about two months
> there weren't any crashes.
+
> It seems that xfs_repair (2.8.10), did not find all of the errors of the FS.
> Is there a way to be sure that the FS is clean?

As in faq:
,--
.....
|   Update: a fixed xfs_repair is now available; version 2.8.10 or later
|   of the xfsprogs package contains the fixed version.
.....      
|   The xfs_check tool, or xfs_repair -n, should be able to detect any
|   directory corruption.
`--     

[]
> Normally  the Kernel freezes/hangs completely, but I found two new

Do you mean panic or oops here, or just freeze?

____
