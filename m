Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSIZAmq>; Wed, 25 Sep 2002 20:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261852AbSIZAmp>; Wed, 25 Sep 2002 20:42:45 -0400
Received: from ns.suse.de ([213.95.15.193]:24074 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261807AbSIZAld>;
	Wed, 25 Sep 2002 20:41:33 -0400
Date: Thu, 26 Sep 2002 02:46:45 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, niv@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
Message-ID: <20020926024645.A15246@wotan.suse.de>
References: <3D924F9D.C2DCF56A@us.ibm.com.suse.lists.linux.kernel> <20020925.170336.77023245.davem@redhat.com.suse.lists.linux.kernel> <p73n0q5sib2.fsf@oldwotan.suse.de> <20020925.172931.115908839.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925.172931.115908839.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 05:29:31PM -0700, David S. Miller wrote:
>    The current FIBs have a bit heavier locking at least. Fine grain locking
>    btrees is also not easy/nice.
>    
> Also not necessary, only the top level cache really needs to be
> top performance.

Sure, but if they were unified (that is what I understood what the original
poster wanted to do) then they would be suddenly much more performance
critical and need fine grained locking.

-Andi

P.S.: One big performance problem currently is ip_conntrack. It has a bad
hash function and tends to have a too big working set (beyond cache size)
Some tuning in this regard would help a lot of workloads.

