Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267193AbTAMLUZ>; Mon, 13 Jan 2003 06:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTAMLUZ>; Mon, 13 Jan 2003 06:20:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31281 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267193AbTAMLUX>; Mon, 13 Jan 2003 06:20:23 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
References: <20030112220741.GA15849@mars.ravnborg.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2003 04:24:33 -0700
In-Reply-To: <20030112220741.GA15849@mars.ravnborg.org>
Message-ID: <m1znq5fg26.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> Recently we have seen seveal changes to arch/*/vmlinux-lds.S,
> mainly introduced by the module support but also other changes.
> 
> This is first version, where I have converted i386, s390 and sparc64.
> The latter two is not tested, only to make sure it can be used by more
> than one platform.
> 
> include/asm-generic/vmlinux.lds contains common definitions.
> inserted below + three diffs.
> 
>  i386/vmlinux.lds.S    |  148 ++++++++++++++---------------------------------
>  s390/vmlinux.lds.S    |  138 +++++++++++++-------------------------------
>  sparc64/vmlinux.lds.S | 156 +++++++++++++++++++-------------------------------
> 
>  3 files changed, 149 insertions(+), 293 deletions(-)
> 
> The architecture specific files became smaller.
> And adding new stuff is easier.
> 
> If this the correct way of doing it - or do you have any better ways
> to do it?


You are changing the Language that vmlinux.lds.S is written in.
It appears to reduce readability by hiding information.  I'm not
in favor of it.

Eric
