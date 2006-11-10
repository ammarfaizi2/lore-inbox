Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424436AbWKJU54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424436AbWKJU54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424434AbWKJU54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:57:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39148 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161909AbWKJU5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:57:55 -0500
Message-ID: <4554E7C1.1070705@sandeen.net>
Date: Fri, 10 Nov 2006 14:57:37 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] handle ext3 directory corruption better
References: <200610211129.23216.sgrubb@redhat.com> <20061031095742.GA4241@ucw.cz> <200611011029.39295.sgrubb@redhat.com>
In-Reply-To: <200611011029.39295.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Grubb wrote:
> On Tuesday 31 October 2006 04:57, Pavel Machek wrote:
>> Nice... can you run the same tool against fsck, too?
> 
> I'll see if I can make that work, too. The fuzzer tries to preserve the bad 
> image so that you can replay the problem for debugging. I think its just a 
> matter of making another copy and using that one instead.

I played with this on xfs a little bit in my spare time, found some
xfs_repair problems.  :)  I'm sure other fs's would have issues as well.

Ideally it would probably be good for the tool to have a "use" mode (try
to use the corrupted fs) and a "check" mode (try to fsck the corrupted fs).

In use   mode, it'd be:  mkfs, fuzz, mount, populate (etc), unmount.
In check mode, it'd be:  mkfs, mount, populate, unmount, fuzz, fsck.

-Eric
