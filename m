Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWAVUrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWAVUrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAVUrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:47:16 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:12992 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751322AbWAVUrP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:47:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ai7T+KT+4poAZ+sKvLd2mQnH6uWn78SISPvPQOv0uBTLr3E+syFHQebBwJ9Zq53whbNJnVm/LTpSU+5pxViArsflT93I1ZzespnkGBn6fnEHSORXHQoQoismBCZfS906kf7ixARdSYy376fB94ObkLHduRfE/CCg7Dy8pCzAQ8I=
Message-ID: <787b0d920601221240m1fbe25d9k3b050b4505042d1@mail.gmail.com>
Date: Sun, 22 Jan 2006 15:40:29 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add /proc/*/pmap files
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060122115856.42231368.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601220150n2e34e376i856cc583a372e1f2@mail.gmail.com>
	 <1137940577.3328.14.camel@laptopd505.fenrus.org>
	 <787b0d920601221117l78a92fd1udc8601068dbde42c@mail.gmail.com>
	 <1137959059.3328.45.camel@laptopd505.fenrus.org>
	 <20060122115856.42231368.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Andrew Morton <akpm@osdl.org> wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> >  you're making a NEW file
>
> One which, afaict, contains the same thing as /proc/pid/smaps only in a
> different format.  If there's a point to this patch, we weren't told what
> it is.

First of all, it isn't just the same. I need to know if
memory is locked or not. I need to know the page size.

Second of all, smaps is surely a parody of bad file
format design. When I first heard of the patch, I was
certain that it would be rejected for that reason.
At the time I was to sick and busy to even comment
on the matter. It was with shock and horror that I
later found the patch in the kernel.

I can't just fix smaps now, because that would break
a rotten ABI. Patching it out should work OK though,
because it is recent enough that apps will still support
kernels without it. I would have done so with this patch,
but you supposedly don't care for big patches.
