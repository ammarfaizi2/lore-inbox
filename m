Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTJKIgd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 04:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTJKIgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 04:36:33 -0400
Received: from pD9FFBFB4.dip.t-dialin.net ([217.255.191.180]:32154 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S263179AbTJKIgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 04:36:32 -0400
Date: Sat, 11 Oct 2003 10:36:28 +0200
From: Patrick Mau <mau@oscar.ping.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Subject: Re: 2.6.0-test6 NFS?
Message-ID: <20031011083628.GA13545@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
References: <20031008224903.GA1464@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031008224903.GA1464@rdlg.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 06:49:03PM -0400, Robert L. Harris wrote:
> 
> 
>   I've been trying to run my NFS server on 2.6 kernels for a while now.
> My desktop and my Firewall are both 2.6 already and happy.  My
> fileserver though is giving me an ulcer.

[...]

>   I get the stale handles.  Reverting back to 2.4 and all is well on the
> same export and mount configs.
> 
> Thoughts?

Hallo Robert,

you could search the archives for "NFS Problem" and "STALE", you
will probably find my post near end of September. The short solution:

Use "no_subtree_check" in /etc/exports like this:

/home \
  tony.local.net(rw,sync,no_root_squash,no_subtree_check)

I think I have found a bug in the nfs server code that always
returns a failure on subtree checks. I described my findings in
a post to this list, but nobody answered.

Patrick
