Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWDSPy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWDSPy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWDSPy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:54:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50312 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750951AbWDSPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:54:56 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>
	<20060407183600.E40C119B902@sergelap.hallyn.com>
	<4446547B.4080206@sw.ru>
	<20060419152129.GA14756@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 09:52:42 -0600
In-Reply-To: <20060419152129.GA14756@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Wed, 19 Apr 2006 10:21:29 -0500")
Message-ID: <m1bquxmuk5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Kirill Korotaev (dev@sw.ru):
>> Serge,
>> 
>> can we do nothing with sysctls at this moment, instead of commiting hacks?
>
> Please look closer at the patch.
>
> I *am* doing nothing with sysctls.
>
> system_utsname no longer exists, and the way to get to that is by using
> init_uts_ns.name.  That's all this does.

Ack.  I probably read that question backwards.

Yes you must at least touch kernel/sysctl.c when you kill
system_utsname.

I read it as: Can we do nothing better with sysctls that commiting hacks?

Eric
