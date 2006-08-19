Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWHSQx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWHSQx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWHSQx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:53:57 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:54735 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422712AbWHSQxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:53:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MPpNhi7EbZUCrBM8NlXaA2f1ykU48PqzhogTM9RlVp//eVvWBPnXlGOS11gPOaD25tXu3caLf7XCWI7Yh8h1vwpbm6Vgr56w2GEik8oWA7GJ2HFlYqOK4h/tOoVtgeSvqhnnB2QdYttKavp5AJxje7ujEXg7ksNJ6EVaVaoMAKY=
Message-ID: <2c0942db0608190953r71ad8716vc2d11d9366894e40@mail.gmail.com>
Date: Sat, 19 Aug 2006 09:53:54 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Cc: "Daniel Phillips" <phillips@google.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "David Miller" <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "Mike Christie" <michaelc@cs.wisc.edu>
In-Reply-To: <20060818194435.25bacee0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808211731.GR14627@postel.suug.ch>
	 <20060813215853.0ed0e973.akpm@osdl.org> <44E3E964.8010602@google.com>
	 <20060816225726.3622cab1.akpm@osdl.org> <44E5015D.80606@google.com>
	 <20060817230556.7d16498e.akpm@osdl.org> <44E62F7F.7010901@google.com>
	 <20060818153455.2a3f2bcb.akpm@osdl.org> <44E650C1.80608@google.com>
	 <20060818194435.25bacee0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/06, Andrew Morton <akpm@osdl.org> wrote:
>   I assert that this can be solved by putting swap on local disks.  Peter
>   asserts that this isn't acceptable due to disk unreliability.  I point
>   out that local disk reliability can be increased via MD, all goes quiet.
>
>   A good exposition which helps us to understand whether and why a
>   significant proportion of the target user base still wishes to do
>   swap-over-network would be useful.

Adding a hard drive adds $low per system, another failure point, and
more importantly ~3-10 Watts which then has to be paid for twice (once
to power it, again to cool it). For a hundred seats, that's
significant. For 500, it's ranging toward fully painful.

I'm in the process of designing the next upgrade for a VoIP call
center, and we want to go entirely diskless in the agent systems. We'd
also rather not swap over the network, but 'swap is as swap does.'

That said, it in no way invalidates using /proc/sys/vm/min_free_kbytes...

Ray
