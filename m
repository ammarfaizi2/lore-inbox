Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVJCTeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVJCTeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVJCTe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:34:29 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:29726 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932653AbVJCTe2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:34:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hkcUqrmEuSryUa+lXeX9xLbyAH0F/4/aeI57BYnx0j4GbYhEHJ2fN6EGaaa/9/Hc+y4tyxCPoosQ40thwOMP2wGH4+e3Do+zkfjx7B5QcTbrI+EeA/24enqxYDmudTvJE0Rd11ab+stIJfZXO6C1nIwqfouxiSn9UjJwzK9yTQk=
Message-ID: <58cb370e0510031234h6ddef197od6c1efb5fa406435@mail.gmail.com>
Date: Mon, 3 Oct 2005 21:34:26 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH 5/7] AMD Geode GX/LX support
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com,
       linux-ide@vger.kernel.org
In-Reply-To: <20051003175851.GG29264@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051003175851.GG29264@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/3/05, Jordan Crouse <jordan.crouse@amd.com> wrote:
> The following is a patch enabling IDE DMA for the CS5535 companion chip.
> linux-ide folks, this is an updated version of the patch that was submitted
> last night by Jaya Kumar.   Both patches share the same history, and probably

Unfortunately it is not updated version of Jaya's patch but the updated version
of the original 2.6.x patch and it misses 2 iterations of bugfixes/cleanups:

http://marc.theaimsgroup.com/?l=linux-ide&m=112832700817260&w=2

>From what I see the main differences between _original_ patch and this one are:
* /proc/ide/cs5535 (sorry but new /proc bloat won't be accepted)
* different way of setting PIO command timings
  (but this method won't ever set timings > 0 if initially timings were bad)
* trusting BIOS to set correct mode also on drive's side (this breaks Power
  Management support and I will prefer to have known state from Linux POV)

It would be the best to join efforts so could somebody from AMD take a look
at Jaya's latest patch and read related linux-ide ML thread?

Thanks,
Bartlomiej
