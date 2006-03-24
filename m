Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWCXPiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWCXPiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWCXPiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:38:13 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:63911 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1751031AbWCXPiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:38:11 -0500
Message-ID: <4424125E.5000205@sw.ru>
Date: Fri, 24 Mar 2006 18:38:06 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>	<1142967011.10906.185.camel@localhost.localdomain> <m1k6anq8uq.fsf@ebiederm.dsl.xmission.com> <44222420.4040403@vilain.net>
In-Reply-To: <44222420.4040403@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I made a preliminary attempt to rebase the /proc hooks atop of your
> work. I looked forward to being ready for if a patchset like this got
> adopted to -mm to be able to hand that piece over :-).
I strongly object against using /proc hooks to get virtualization-like
solution.
You endup with lots of hooks and unmaintainable code.
Also though it works find with a small subset of /proc and sysctl, it
works poorly with dynamic trees, as the same entries can be
created in container, though they already exist in host. e.g. network
device names.

Thanks,
Kirill


