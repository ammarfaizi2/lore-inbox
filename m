Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVBUNxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVBUNxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 08:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVBUNxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 08:53:30 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:12025 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261974AbVBUNxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 08:53:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LRSLZsoJGvAaOFB12GaliGvo3GlvHOMsOmhme07on/eqbxDZ4dcSMUKGcv27HNOrA6SJZMILGtCj4e+g0Ipv2AG7hUgQdmTeEx1x6dy/ppbeur3zlkvZA7Z6ZCz7YPiZv++nCRDk9acIvYCHtUbzAc2SfrdPODhfqayYjNiwWg8=
Message-ID: <84144f0205022105532bad35f7@mail.gmail.com>
Date: Mon, 21 Feb 2005 15:53:19 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Baruch Even <baruch@ev-en.org>
Subject: Re: [PATCH] /proc/kmalloc
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi
In-Reply-To: <42194AE0.2040209@ev-en.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050220204743.GE3120@waste.org> <42194AE0.2040209@ev-en.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 02:43:44 +0000, Baruch Even <baruch@ev-en.org> wrote:
> One thing I've seen once that might be worth adding is the ability to
> mark generations and then ask "what allocations exist from generation x?".

In less general terms, I would like to see which module made the
allocation so after doing rmmod I could see if the module leaks
memory. Many subsystems are already doing this by intercepting
kmalloc() and kfree() calls so it would be nice to get rid of the
duplication...

                         Pekka
