Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWDXLWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWDXLWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 07:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDXLWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 07:22:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:62931 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750731AbWDXLWP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 07:22:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nhux6y1jzYHy/Ukwc8OTT7zxM+UJ++TR0Giqo1K4ZiXoVHeloFY4fru4gFr27C750JTAk94XEnBvRqiCq+qaEEnjB2UUMvCG7DhEfh89FVZMzfF7qOvjD7gOTgAKu8hmsjH0YxOlYqQwXeno6gdpra+CuqXKRKj09avF5rlTfNQ=
Message-ID: <84144f020604240422v3f0cd85fm6f45d263d60803cf@mail.gmail.com>
Date: Mon, 24 Apr 2006 14:22:15 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Al Boldi" <a1426z@gawab.com>
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200604241412.13267.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511142327.18510.a1426z@gawab.com>
	 <200604240756.42483.a1426z@gawab.com>
	 <20060423221157.6a4b5c8e.akpm@osdl.org>
	 <200604241412.13267.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Al Boldi <a1426z@gawab.com> wrote:
> Like so?
>         if (nr_threads >= max_threads)
>                 if (p->pid != su_pid)
>                         goto bad_fork_cleanup_count;

It's better to combine the two if statements into one with &&.

                                  Pekka
