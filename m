Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWGYMsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWGYMsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 08:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGYMsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 08:48:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19668 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751226AbWGYMsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 08:48:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jyRgutDxz6iAwar7yPvgddqJ79NGesWpWMH6sTmRgwi8SxASBaqGE8PAN9JPOBxZN6ArqPo/v44Iqmh7ceJz201u3ABzDsq9BRyWf339bMsp8JP9fAEpxzd8sKTsLhapEcFtuF2vFbRIRbBBUnJkoCJTjcHapfj5YgEY7ZeyJ2M=
Message-ID: <f96157c40607250547m5af37b4gbab72a2764e7cb7c@mail.gmail.com>
Date: Tue, 25 Jul 2006 14:47:59 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Re: i686 hang on boot in userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060725112955.GR4044@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725073208.GA10601@suse.de> <20060725074107.GA4044@suse.de>
	 <f96157c40607250120s2554cbc6qbd7c42972b70f6de@mail.gmail.com>
	 <20060725080002.GD4044@suse.de>
	 <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com>
	 <20060725080807.GF4044@suse.de>
	 <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com>
	 <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com>
	 <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
	 <20060725112955.GR4044@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Jul 25 2006, gmu 2k6 wrote:
> > ok, let's nail it to 2.6.17-git5 instead as it survived git status
> > compared to -git6
> > which seems to have correctly booted by accident the lastime. timing issues
> > I guess.
>
> I will try and reproduce it here now. It seems to be in between commit
> 271f18f102c789f59644bb6c53a69da1df72b2f4 and commit
> dd67d051529387f6e44d22d1d5540ef281965fdd where the first one could also
> be bad.
>
> I'm assuming that acf421755593f7d7bd9352d57eda796c6eb4fa43 should be
> good, so you can try and verify that
> dd67d051529387f6e44d22d1d5540ef281965fdd is bad and bisect between the
> two. It's only about 6 commits, so should be quick enough to do.

1) no luck with remote serial console
2) netconsole does not work although connecting to the listener with netcat and
 sending strings works
I'm gonna try via physical rs232 9pins and see how that works.
afterwards I will try to bisect the revisions you mentioned.

btw, the issue seems to come and go as I managed to boot log into a .17-git6
kernel or is timing-dependent.
