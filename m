Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWHWOt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWHWOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWHWOtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:49:55 -0400
Received: from gw.goop.org ([64.81.55.164]:38052 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964911AbWHWOtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:49:55 -0400
Message-ID: <44EC6B12.4060909@goop.org>
Date: Wed, 23 Aug 2006 07:49:54 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Ian Campbell <Ian.Campbell@XenSource.com>
CC: Andrew Morton <akpm@osdl.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro into preprocessor
 macro
References: <1156333761.12949.35.camel@localhost.localdomain>
In-Reply-To: <1156333761.12949.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:
> The first is that older gas does not support :varargs in .macro
> definitions (in my testing 2.17 does while 2.15 does not, I don't know
> when it became supported). The Changes file says binutils >= 2.12 so I
> think we need to avoid using it. There are no other uses in mainline or
> -mm. Old gas appears to just ignore it so you get "too many arguments"
> type errors.
>   
OK, seems reasonable.  Eric Biederman solved this by having NOTE/ENDNOTE 
(or something like that) in his "bzImage with ELF header" patch, but I 
don't remember it being used in any way which is incompatible with using 
a CPP macro.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

    J
