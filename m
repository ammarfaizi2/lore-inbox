Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWHULWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWHULWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWHULWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:22:44 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:18377 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S964961AbWHULWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:22:44 -0400
Date: Mon, 21 Aug 2006 12:22:42 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] drm, minor fixes
In-Reply-To: <20060820121706.GG720@slug>
Message-ID: <Pine.LNX.4.64.0608211220450.16712@skynet.skynet.ie>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060819231621.GF720@slug>
 <1156066626.23756.3.camel@laptopd505.fenrus.org> <20060820121706.GG720@slug>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> are you sure the callers of these don't wrap it inside a DRM_ERR()
>> macro ?
> I changed the values when:
> - I've checked what seemed right, getting back to the system call.
>  drm_ioctl(), through a call to func().
>  That's the case for:
>  - the EFAULT value in i915_emit_box
>  - two EINVAL values in drm_setversion
> - the return value wasn't used. That was the case for
>  drm_set_busid return values, I felt having returned values negative
>  from the start was more consistent.
>
> Is there a particular change that looked suspicious to you?

These are all actual bugs , however I doubt any of the codepaths are 
causing a major problem, a lot of those code paths are for older X 
systems or not very likely hit, I'll pull the fixes into the DRM tree 
now... the i915 one is a worry I must give out the TG/Intel folks :-)

Thanks,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

