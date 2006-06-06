Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWFFKql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWFFKql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWFFKql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:46:41 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:30126 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750800AbWFFKqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:46:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uslnqr4iku4Om8qIfVMDo+XltgrVQU17Q8OSo9JaPABHCUnffToTdJdTgF7Cuddr0yL6A9OtdMHCV7uGV576yHy9IIvMBMy5EkLdSF+b8FgU3PepZL6qglFgqnpHe9NJcf/BLvRPTWFWCetAxYXZcg7dQAudV6P6suZDdRAhkkU=
Message-ID: <b0943d9e0606060346sb42e00apbc194cee8db3986d@mail.gmail.com>
Date: Tue, 6 Jun 2006 11:46:40 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.17-rc5 0/8] Kernel memory leak detector 0.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0606051452p26f20c8r57f2c782de691210@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
	 <6bffcb0e0606051452p26f20c8r57f2c782de691210@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> System hangs while starting udev.
>
> Here is config
> http://www.stardust.webpages.pl/files/kml/kml-config

I managed to reproduce the problem - the kernel can deadlock on SMP if
the module being loaded contains the .init.memleak_aliases section.
I'll fix it and post another patch later today.

Thanks for testing.

-- 
Catalin
