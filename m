Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWGLJ5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWGLJ5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGLJ5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:57:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:39356 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751217AbWGLJ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:57:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=Zmd/A7Z9NfiNXGLhZHNj1of22m2jU3cyF4LltKHdNkbGetxO2gTGG4ve1ohX7Ye6Pbn5BttbfzoG/7tEfqZHA9GSOv/bBr01+gsXikSRkiA9qk62AisCCojh4fPbRyG3FTv4jIjmTPUvsZ/hts5i2yK2ZmaFpxj97CWrBmMsWd8=
Date: Wed, 12 Jul 2006 05:57:31 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Message-ID: <20060712095730.GA19478@nineveh.rivenstone.net>
Mail-Followup-To: Catalin Marinas <catalin.marinas@gmail.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20060710220901.5191.66488.stgit@localhost.localdomain> <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com> <6bffcb0e0607110546r11d2f619pbcd1205999253bd@mail.gmail.com> <6bffcb0e0607110551v272deebcua5dc3f782ed25a7f@mail.gmail.com> <b0943d9e0607110600q345b5ad7y38174b85cf01edba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0607110600q345b5ad7y38174b85cf01edba@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 02:00:05PM +0100, Catalin Marinas wrote:
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> >On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> >> When I set DEBUG_KEEP_INIT=n everything works fine.
> >
> >I was wrong.
>
> You mean the previous e-mail wasn't a kmemleak bug?
>
> >Here is the new error
> >/usr/src/linux-work4/kernel/pid.c: In function 'pid_task':
> >/usr/src/linux-work4/kernel/pid.c:262: error: initializer element is
> >not constant
> >/usr/src/linux-work4/kernel/pid.c:262: error: (near initialization for
> >'__memleak_offset__container_of.offset')
> >make[2]: *** [kernel/pid.o] Error 1
> >make[1]: *** [kernel] Error 2
> >make: *** [_all] Error 2
>
> That's a bug in gcc-4. The __builtin_constant_p() function always
> returns true even when the argument is not a constant. You could try a
> gcc-3.4 or a patched gcc.

    Which gcc versions are affected by this?
--
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.
