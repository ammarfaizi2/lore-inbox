Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314037AbSDKMsc>; Thu, 11 Apr 2002 08:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314038AbSDKMsb>; Thu, 11 Apr 2002 08:48:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60678 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314037AbSDKMsb>; Thu, 11 Apr 2002 08:48:31 -0400
Date: Thu, 11 Apr 2002 08:45:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Alexis S. L. Carvalho" <alexis@cecm.usp.br>,
        linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
In-Reply-To: <20020410025504.GD424@turbolinux.com>
Message-ID: <Pine.LNX.3.96.1020411083829.3677A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Andreas Dilger wrote:

> On Apr 09, 2002  20:41 -0400, Albert D. Cahalan wrote:
> > In case you are still thinking about what to do, here are a
> > few filesystem ideas that you might like:

> > mark idle filesystems clean; mark dirty before non-atomic updates
> - maybe marginally useful

  I would think far mnore than marginally useful... this would provide
an improved possibility of avoiding fsck, something many people would find
desirable. And along that line I'll offer one more idea, not to increment
the mount count if a f/s is mounted and no writes are done to the f/s,
such as ro mount, noatime mount and no writes, etc. The check for fsck
after N mounts was designed to assist with reliability, not be a penalty
in boot time.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

