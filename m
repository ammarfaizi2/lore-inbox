Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWHIUNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWHIUNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWHIUNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:13:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:20403 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751353AbWHIUNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:13:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JU2Yr4Hs3u+lW8lEL8BIi492/1ntT6kAm2DsdOV8Drufh3MIhTyvcw4uOxytL9SND0xRCV2la6aPHNzaYEmUWDFPks1wgwxkaBLQp9U9oJTJQVvgxzYK0iQNgUTn29oJAGypcf2LE1K819mvt1jWcf7frfFPAGd5rXp7WYz3Scg=
Message-ID: <d120d5000608091313t7043c3b5n38ae6f45c5df9fe1@mail.gmail.com>
Date: Wed, 9 Aug 2006 16:13:38 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: 2.6.18-rc3-mm2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <b637ec0b0608091247u7d0b7b5ds202b5e89599e8e2d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <d120d5000608081124s53777b42v4bb4d48c90f6a59e@mail.gmail.com>
	 <b637ec0b0608081136o3adf98dbn15e206c8eea41a1c@mail.gmail.com>
	 <200608082347.22544.dtor@insightbb.com>
	 <b637ec0b0608091247u7d0b7b5ds202b5e89599e8e2d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> Hi Dmitry.
>
> On 8/9/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > Could you please try applying the patch below on top of -rc3-mm2 and
> > see if it works without needing i8042.nomux?
> >
>
> Yes, it works for me too.

Thank you for testing.

> However, Andrew put a revert patch for
> remove-polling-timer-from-i8042-v2.patch in his hot-fixes directory.
> So, which one should be considered the correct fix?

I'd rather have him replace reverting patch with this one. Removing
polling timer is needed for tickless operation.

-- 
Dmitry
