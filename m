Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVCHIZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVCHIZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 03:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVCHIZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 03:25:10 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:31689 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261776AbVCHIZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 03:25:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MPrTTKwqbrVPSrPyJa/JegkWK7VCbtfF89AYMv5Es/Nm2pM5Ya3bvB3z/zdtNCyDIMhw8z6oPOVRS8HybM9IxLyAhflnVP/abIWY8kp9WrMK2x5XNrZM1NonGl4KlpAgXmnvvbROm4eDZNhb+akQDi+RPE5+mPewriKkh53dUOo=
Message-ID: <58cb370e0503080024adfea23@mail.gmail.com>
Date: Tue, 8 Mar 2005 09:24:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] unexport complete_all
Cc: mike@waychison.com, bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e050304051424b29c3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422817C3.2010307@waychison.com>
	 <58cb370e0503040240314120ea@mail.gmail.com>
	 <20050304031504.4ea49f83.akpm@osdl.org>
	 <58cb370e050304051424b29c3d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005 14:14:39 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Fri, 4 Mar 2005 03:15:04 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > >
> > > Andrew, what is the policy for adding exports for out of tree GPL code?
> > >
> >
> > There isn't one.  Such things cause way too much email.
> 
> Lack of policy causes the same thing (ie. this thread).
> 
> > What complete_all() does is to permit more than one task to wait on a
> > completion and for all those tasks to be woken by a single complete().
> > Without it you'd need to record how many tasks are sleeping there and do
> > complete() that many times.
> >
> > So it's a sensible part of the completion API from a regularity-of-the-API
> 
> This function was already part of in-kernel API, just wasn't exported
> for modules because there were no in-kernel users.
> 
> > POV.  We use it in the coredump code and I don't think we'd be likely to want
> > to rip it out.

It was my misunderstanding w.r.t. 'We' here...

> OK, I understand that the unwritten policy is the following:
> symbols for out-of-tree code used by OSDL are fine. 8)

/me takes this bad joke back and says sorry to Andrew

> > In fact, I'd say that complete() should have always done it this way...
