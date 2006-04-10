Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWDJBQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDJBQW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 21:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWDJBQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 21:16:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55699 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750851AbWDJBQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 21:16:21 -0400
Message-ID: <4439B1CA.2080806@vilain.net>
Date: Mon, 10 Apr 2006 13:15:54 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [PATCH 0/7] uts namespaces: Introduction
References: <20060407234815.849357768@sergelap>
In-Reply-To: <20060407234815.849357768@sergelap>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge,

I have just imported your series into the GIT repository where I have
been collating the various recent related submissions at:

  git://vserver.utsl.gen.nz/vserver

A summary of the submissions imported to date are at:

  http://www.utsl.gen.nz/gitweb/?p=vserver;a=heads

I will endeavour to continue to collect and catalogue all vserver
related submissions I receive, see on LKML, or get pull requests for, as
a part of my efforts to merge this functionality.

Sam.

Serge E. Hallyn wrote:

>Introduce utsname namespaces.  Instead of a single system_utsname
>containing hostname domainname etc, a process can request it's
>copy of the uts info to be cloned.  The data will be copied from
>it's original, but any further changes will not be seen by processes
>which are not it's children, and vice versa.
>
>This is useful, for instance, for vserver/openvz, which can now clone
>a new uts namespace for each new virtual server.
>
>Aside from the debugging patch which comes last, this patchset does
>not actually implement a way for processes to unshare the uts namespace.
>The proper unsharing semantics are to be worked out later.
>
>Changes since last submission:
>  Restructured patchset so it compiles after each patch
>  Removed EXPORT_SYMBOL for unshare_uts_ns and free_uts_ns.
>    The former is now in the debugging pach and the latter gone
>    entirely, as unsharing is likely not something to be done
>    from modules!
>
>-serge
>
>
>  
>

