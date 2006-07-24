Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWGXFrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWGXFrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 01:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWGXFrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 01:47:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:32491 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751408AbWGXFrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 01:47:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=G6Lbf0vKaR64HhLaSjRgTnD8PLdSxbrYl+1ktsz6K0dEA7FzUPabQhfFafqqxY9yAOBOd/8XIq5wldiww9CsNwhHtZ4SXbfiaz1BJsytnfO5NxBNAtFJYg2fRbfxLqXbRk7LPbb7R3LN2Eq/W3QddskOlxABL+9zt+dVvWImwkM=
Date: Mon, 24 Jul 2006 07:46:55 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent usage of uninitialized variable in transmeta cpu driver
Message-ID: <20060724054655.GA7213@leiferikson.gentoo>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060723214834.GA1484@leiferikson.gentoo> <44C40CD3.80000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C40CD3.80000@gmail.com>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 24, 2006 at 01:56:44AM +0159, Jiri Slaby wrote:
> Johannes Weiner napsal(a):
> > This patch fixes a gcc-`uninitialized' warning in
> > arch/i386/kernel/cpu/transmeta.c.
> 
> NACK.
> 
> Gcc bug, don't hide it (I don't really know, why cpu_rev is zeroed).

Ok. This GCC release I'm running (4.1.1) shows really a lot more of
them then the prior. Should have wondered and thought about it before ;)

Hannes

-- 
#include <stdio.h>
char *love[] = { "this", "language" };
#define gimme(s) #s, 0[s], 0[s+1]
int main(void) { printf("%s %s %s\n", gimme(love)); return 0; }
