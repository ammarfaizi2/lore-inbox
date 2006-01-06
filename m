Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWAFLvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWAFLvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWAFLvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:51:44 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:30664 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbWAFLvo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:51:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j0X07AwCasHJxY10tY2RHgJ8c8aMGP3U/TY+PVJVaPhedc7RZmQPYVgY7bWAw8naViBEHpXMY+x0zm9yLNoAMK7LpqHMnaWmtgV1mbRZ7opSmjx6sh5zuz3bwXVOCicpmwLZ24OpjtADcCoUEgZALb7JsPzLqY66gmKFW4wWN3o=
Message-ID: <84144f020601060351g48f3ef5bqf25a2a1bf02af4e6@mail.gmail.com>
Date: Fri, 6 Jan 2006 13:51:41 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Remove gfp argument from kstrdup()
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060105234253.758b126a.tihirvon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105234253.758b126a.tihirvon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Timo Hirvonen <tihirvon@gmail.com> wrote:
> All kstrdup() callers use GFP_KERNEL flag so this parameter seems to be
> useless.

Please don't. You're making the API inconsistent and forcing everyone
to use GFP_KERNEL for little or no benefit.

                              Pekka
