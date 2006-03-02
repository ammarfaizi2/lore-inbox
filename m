Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWCBSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWCBSdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWCBSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:33:33 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:42953 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750976AbWCBSdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:33:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=AcM9gQDumbLtjcGu3f4BXLym2xqHnjDpSxqAh6x7mP4VWu6EhFqB5wwm5TczlBc/i6bNUN+qFjafY3bhUBRPMwOAYDmRwLpHDJU9Ib0yNQsBQsOHSuyZ2HParsfK7l+MoaspEHIxZWogZC4Rt93zkBu1qyT7bQ6plPOHyqa9CHE=
Date: Thu, 2 Mar 2006 19:33:25 +0100
From: Frederik Deweerdt <deweerdt@free.fr>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org,
       FACCINI BRUNO <Bruno.Faccini@bull.net>
Subject: Re: Deadlock in net/sunrpc/sched.c
Message-ID: <20060302183325.GB12335@silenus.home.res>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr> <20060302105940.GA9521@silenus.home.res> <Pine.LNX.4.61.0603021242150.15393@openx3.frec.bull.fr> <Pine.LNX.4.61.0603021306540.15393@openx3.frec.bull.fr> <20060302175126.GA12335@silenus.home.res> <1141322282.10398.22.camel@netapplinux-10.connectathon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141322282.10398.22.camel@netapplinux-10.connectathon.org>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 09:58:02AM -0800, Trond Myklebust wrote:
> You need a list_for_each_entry_safe() here, since __rpc_wake_up_task()
> will cause the task to be removed from the list. See the patch I sent
> out 1/2 hour ago.
> 
Indeed, I missed it. Thanks,
Frederik
