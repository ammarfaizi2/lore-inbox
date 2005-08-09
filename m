Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVHIW63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVHIW63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 18:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVHIW63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 18:58:29 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:61835 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750958AbVHIW62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 18:58:28 -0400
Date: Wed, 10 Aug 2005 00:58:18 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Chris Wright <chrisw@osdl.org>
cc: Bodo Eggert <7eggert@gmx.de>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capabilities patch (v 0.1)
In-Reply-To: <20050809222441.GJ7991@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0508100036200.11207@be1.lrz>
References: <4zuQJ-20d-11@gated-at.bofh.it> <4zv0l-2b8-11@gated-at.bofh.it>
 <E1E2aaq-0002WB-Tj@be1.lrz> <20050809205206.GW7762@shell0.pdx.osdl.net>
 <Pine.LNX.4.58.0508092259570.9779@be1.lrz> <20050809222441.GJ7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Chris Wright wrote:
> * Bodo Eggert (7eggert@gmx.de) wrote:

> > 1) I wouldn't want an exploited service to gain any privileges, even by
> >    chaining userspace exploits (e.g. exec sendmail < exploitstring).  For
> >    most services, I'd like CAP_EXEC being unset (but it doesn't exist).
> 
> Don't let it exec things it shouldn't.  This can be done with namespaces
> or for finer-grained, that is what smth like SELinux is made for.

Namespaces may be OK for bind, but things like samba can't really use them 
and SELinux sounds more heavyweight (for brain and CPU).

> > 2) There are environments (linux-vserver.org) which limit root to a subset
> >    of capabilities. I think they might use that feature, too. Off cause a
> >    simple "suid bit" == "all capabilities" scheme won't work there.
> 
> IIRC, they effectively use the bounded set as per-context.  So it'd not
> make any difference there.

It could possibly be combined into one mechanism (less intrusive patch).

-- 
Funny quotes:
14. Eagles may soar, but weasels don't get sucked into jet engines.
