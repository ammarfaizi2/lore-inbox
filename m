Return-Path: <linux-kernel-owner+w=401wt.eu-S932310AbXADH35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbXADH35 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbXADH35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:29:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4678 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbXADH34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:29:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fAM0c8RNRxxdZTo9fXdhrZKmgStoDRKPvD9WuI+2cTxKygrEnAGRlTjAmVv98S0DdYvNWlo65ohUaodpkxy9AnDf6WvIlYfyOBQNtOj9Ca/zUB2xbNtpMTBHv47Ws1ZgnaAPmnvCAnlwS3YoBsLHjGFrLhFOKa4dGscqcCRqAlA=
Message-ID: <84144f020701032329v309a8e4fif130ef5d1f4b1a93@mail.gmail.com>
Date: Thu, 4 Jan 2007 09:29:55 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Mitchell Blank Jr" <mitch@sfgoth.com>
Subject: Re: [PATCH 2.6.20-rc2] [BUGFIX] drivers/atm/firestream.c: Fix infinite recursion when alignment passed is 0.
Cc: "Amit Choudhary" <amit2030@gmail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, chas@cmf.nrl.navy.mil
In-Reply-To: <20061231055906.GE35756@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061230182603.d3815dcb.amit2030@gmail.com>
	 <20061231055906.GE35756@gaz.sfgoth.com>
X-Google-Sender-Auth: 858bb0f1109ac8db
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/06, Mitchell Blank Jr <mitch@sfgoth.com> wrote:
> Looking at aligned_kmalloc() it seems to be pretty badly broken -- its fallback
> if it gets a non-aligned buffer is to just try a larger size which doesn't
> necessarily fix the problem.  It looks like explicitly aligning the buffer
> is a better solution.

Shouldn't we be using dma_alloc_*() here instead of abusing kmalloc()?
