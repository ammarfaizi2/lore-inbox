Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVCNJqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVCNJqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVCNJqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:46:37 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:7575 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262089AbVCNJmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:42:21 -0500
Message-ID: <42355C78.1020307@lsrfire.ath.cx>
Date: Mon, 14 Mar 2005 10:42:16 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
References: <1110771251.1967.84.camel@cube>
In-Reply-To: <1110771251.1967.84.camel@cube>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> This is a bad idea. Users should not be allowed to
> make this decision. This is rightly a decision for
> the admin to make.

Why do you think users should not be allowed to chmod their processes' 
/proc directories?  Isn't it similar to being able to chmod their home 
directories?  They own both objects, after all (both conceptually and as 
attributed in the filesystem).

> Note: I'm the procps (ps, top, w, etc.) maintainer.
> 
> Probably I'd have to make /bin/ps run setuid root
> to deal with this. (minor changes needed) The same
> goes for /usr/bin/top, which I know is currently
> unsafe and difficult to fix.
> 
> Let's not go there, OK?

I have to admit to not having done any real testing with those 
utilities.  My excuse is this isn't such a new feature, Openwall had 
something similar for at least four years now and GrSecurity contains 
yet another flavour of it.  Openwall also provides one patch for 
procps-2.0.6, so I figured that problem (whatever their patch is about) 
got fixed in later versions.

Why do ps and top need to be setuid root to deal with a resticted /proc? 
    What information in /proc/<pid> needs to be available to any and all 
users?

> If you restricted this new ability to root, then I'd
> have much less of an objection. (not that I'd like it)

How about a boot parameter or sysctl to enable the chmod'ability of 
/proc/<pid>, defaulting to off?  But I'd like to resolve your more 
general objections above first, if possible. :)

Thanks for your comments,
Rene
