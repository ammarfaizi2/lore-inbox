Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSCSX0z>; Tue, 19 Mar 2002 18:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSCSX0p>; Tue, 19 Mar 2002 18:26:45 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:65528 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S310660AbSCSX0h>; Tue, 19 Mar 2002 18:26:37 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 19 Mar 2002 12:32:28 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: extending callbacks?
Message-ID: <20020319193228.GS470@turbolinux.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.44.0203191111320.20995-100000@speedy> <a78gd7$jk$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Scheidegger <mscheid@iam.unibe.ch> writes:
> I've got the following problem: I want to register a callback in a kernel
> structure, but I need to supply an additional argument to my own code. I.e. I
> need a callback
> 
> int (*cb)(int u)
> 
> to really call
> 
> int (*real_cb)(int u, void* my_arg)
> 
> At the moment, I'm only focussing on the i386 architecture.

In general, you would pass "my_arg" in a private pointer in a data
struct somewhere.  What function is it that you are calling?  That
may already have the possibility of passing the extra data somewhere.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

