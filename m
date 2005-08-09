Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVHIWYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVHIWYt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 18:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVHIWYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 18:24:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965005AbVHIWYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 18:24:48 -0400
Date: Tue, 9 Aug 2005 15:24:41 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Chris Wright <chrisw@osdl.org>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capabilities patch (v 0.1)
Message-ID: <20050809222441.GJ7991@shell0.pdx.osdl.net>
References: <4zuQJ-20d-11@gated-at.bofh.it> <4zv0l-2b8-11@gated-at.bofh.it> <E1E2aaq-0002WB-Tj@be1.lrz> <20050809205206.GW7762@shell0.pdx.osdl.net> <Pine.LNX.4.58.0508092259570.9779@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508092259570.9779@be1.lrz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bodo Eggert (7eggert@gmx.de) wrote:
> 1) I wouldn't want an exploited service to gain any privileges, even by
>    chaining userspace exploits (e.g. exec sendmail < exploitstring).  For
>    most services, I'd like CAP_EXEC being unset (but it doesn't exist).

Don't let it exec things it shouldn't.  This can be done with namespaces
or for finer-grained, that is what smth like SELinux is made for.

> 2) There are environments (linux-vserver.org) which limit root to a subset
>    of capabilities. I think they might use that feature, too. Off cause a
>    simple "suid bit" == "all capabilities" scheme won't work there.

IIRC, they effectively use the bounded set as per-context.  So it'd not
make any difference there.

thanks,
-chris
