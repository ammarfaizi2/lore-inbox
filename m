Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVHKARV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVHKARV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVHKARV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:17:21 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:63166 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964823AbVHKARV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:17:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OGjaOE6cYvdM+gEoiC9Mz+I87qB3+IsQw2OUbkKzM/rBgW9DeBVZd/xQasFl2u+rnuIzErn+iaNp3z7OHRwXs1fFIJiSKEhhxtFPDzYNLVOkCTDEVVSPwHJsMwqv7dcvfeJ9FnDE0+aXrK05nc6s+z2vDQacQdmjiCO7rkhmqls=
Message-ID: <86802c4405081017174c22dcd5@mail.gmail.com>
Date: Wed, 10 Aug 2005 17:17:17 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Cc: Mike Waychison <mikew@google.com>, YhLu <YhLu@tyan.com>,
       Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org,
       "discuss@x86-64.org" <discuss@x86-64.org>
In-Reply-To: <20050811000430.GD8974@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB>
	 <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de>
	 <86802c4405081016421db9baa5@mail.gmail.com>
	 <20050811000430.GD8974@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In LinuxBIOS, we could init_ecc asynchronous and the time reduced from
8x to 2.1x for 8 ways system. 1x mean 5s for 4G in one cpu. If 16G
will take 20s.

for TSC_SYNC asynchronous maybe you can get back 0.1s...

YH

On 8/10/05, Andi Kleen <ak@suse.de> wrote:
> > So my patch still can be used with Eric's, It just serialize the
> > TSC_SYNC between cpu.
> >
> > I wonder it you can refine to make TSC_SYNC serialize that beteen CPU.
> > That will make
> > CPU X:synchronized TSC ...
> > in fixed postion and timming.
> 
> Why would we want that?
> 
> Boot time is critical so it's better to do things asynchronous.
> 
> -Andi
>
