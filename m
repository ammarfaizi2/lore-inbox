Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWHUMNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWHUMNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWHUMNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:13:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:21898 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030409AbWHUMNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:13:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=kUsxcZWtuMMurufSjlPhw6F0evh8d7b+jReznpvVb5nHscSStBEloScDkCXsco1MtAx5I056TO2H48qc78WXj6nd/fjL7CQqkUT10Csmwg9iRdAECGmvtzQwzWEgViYO0sytxUryWPB3DMTAK5h2CANkWtKN8pK2KR775L+sRRY=
Date: Mon, 21 Aug 2006 14:13:39 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: airlied@linux.ie
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] drm, minor fixes
Message-ID: <20060821141339.GD1919@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, I forgot to CCs.)
On Mon, Aug 21, 2006 at 12:22:42PM +0100, Dave Airlie wrote:
> >>
> >>are you sure the callers of these don't wrap it inside a DRM_ERR()
> >>macro ?
> >I changed the values when:
> >- I've checked what seemed right, getting back to the system call.
> > drm_ioctl(), through a call to func().
> > That's the case for:
> > - the EFAULT value in i915_emit_box
> > - two EINVAL values in drm_setversion
> >- the return value wasn't used. That was the case for
> > drm_set_busid return values, I felt having returned values negative
> > from the start was more consistent.
> >
> >Is there a particular change that looked suspicious to you?
> 
> [...], however I doubt any of the codepaths are causing a major problem [...]
I agree, I just corrected those because I happen to stumble upon them.
I've tried a kernel with those corrections alone, and it didn't changed
anything on the oopses.

Regards,
Frederik

