Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422887AbWBNXfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422887AbWBNXfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422892AbWBNXfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:35:47 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:62931 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422887AbWBNXfr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:35:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FvQerV7ARLkYx3rqfgoAsVO+QdzV6uWHcj7nRHDdl9gTSSte+ql3YjIemsIb/Jaz63NT05eOX3mOJxpuC4peXjc8pPg1SKf6H6cWOFbEh9xIl8SGnWyo5kOYmft57UX16ozFoaPtoipGvJSUUTwJs8oPwDifyeBYoB6ENgz7dPY=
Message-ID: <6bffcb0e0602141535x673a2caay@mail.gmail.com>
Date: Wed, 15 Feb 2006 00:35:46 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Norbert Preining <preining@logic.at>
Subject: Re: 2.6.16-rc3-mm1 build failure
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060214232516.GI4850@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060214232516.GI4850@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/02/06, Norbert Preining <preining@logic.at> wrote:
> HI Andrew!
>
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o: In function `show_type':intel_cacheinfo.c:(.text+0x72c7): undefined reference to `strcpy'
> :intel_cacheinfo.c:(.text+0x72d9): undefined reference to `strcpy'
> :intel_cacheinfo.c:(.text+0x72eb): undefined reference to `strcpy'
> :intel_cacheinfo.c:(.text+0x72fd): undefined reference to `strcpy'
> kernel/built-in.o: In function `prof_cpu_mask_read_proc':profile.c:(.text+0x4a2e): undefined reference to `strcpy'
> kernel/built-in.o:clocksource.c:(.text+0x19b32): more undefined references to `strcpy' follow
> make: *** [.tmp_vmlinux1] Error 1
>
> config is attached
>
> Best wishes
>
> Norbert

Here is patch:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/hot-fixes/x86_64-fix-string-fix.patch

Regards,
Michal Piotrowski
