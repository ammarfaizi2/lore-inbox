Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWKFXug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWKFXug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbWKFXug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:50:36 -0500
Received: from ns.suse.de ([195.135.220.2]:29921 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750732AbWKFXug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:50:36 -0500
From: Andi Kleen <ak@suse.de>
To: "Ulrich Drepper" <drepper@gmail.com>
Subject: Re: [PATCH] conditionalize some x86-64 options
Date: Tue, 7 Nov 2006 00:50:31 +0100
User-Agent: KMail/1.9.5
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
References: <a36005b50611041624x1b9f2602h8d5b90b3337953e2@mail.gmail.com> <200611050208.23814.ak@suse.de> <a36005b50611061519p1dcdce98v9f8cee920ade0f63@mail.gmail.com>
In-Reply-To: <a36005b50611061519p1dcdce98v9f8cee920ade0f63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611070050.31499.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 November 2006 00:19, Ulrich Drepper wrote:
> On 11/4/06, Andi Kleen <ak@suse.de> wrote:
> > No -- the CPU selection on x86-64 means "optimize for", but doesn't
> > mean don't run on other CPUs.
> 
> Then please explain this:
> 
> config X86_HT
>         bool
>         depends on SMP && !MK8
>         default y

HT scheduler is just an optimization -- not needed for any functionality.
Doesn't break anything when not there.

But I agree the && !MK8 is bogus and should be probably removed
(or perhaps moved into a default) 

-Andi

