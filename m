Return-Path: <linux-kernel-owner+w=401wt.eu-S1754180AbWL2Nzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbWL2Nzz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 08:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbWL2Nzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 08:55:55 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:51440 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbWL2Nzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 08:55:54 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 08:55:54 EST
To: Martin Stoilov <mstoilov@odesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobject_add unreachable code
References: <4594BA09.1080509@odesys.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 29 Dec 2006 14:50:44 +0100
In-Reply-To: <4594BA09.1080509@odesys.com> (Martin Stoilov's message of
 "Thu, 28 Dec 2006 22:47:37 -0800")
Message-ID: <87k60azu8b.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Constant Variable,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Stoilov <mstoilov@odesys.com> writes:

> The following code in kobject_add
>     if (!kobj->k_name)
>         kobj->k_name = kobj->name;
>     if (!kobj->k_name) {
>         pr_debug("kobject attempted to be registered with no name!\n");
>         WARN_ON(1);
>         return -EINVAL;
>     }
>
> doesn't look right to me. The second 'if' statement looks useless after
> the assignment in the first one. May be it was meant to be like:
> if (!*kobj->k_name)

The second test is true, if kobj->name is NULL as well.

Regards, Olaf.
