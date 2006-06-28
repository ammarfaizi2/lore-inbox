Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWF1SLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWF1SLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWF1SLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:11:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:21224 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750759AbWF1SLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:11:45 -0400
Message-ID: <5640c7e00606281111y2b4e6d4at611d0195847377cc@mail.gmail.com>
Date: Thu, 29 Jun 2006 06:11:45 +1200
From: "Ian McDonald" <ian.mcdonald@jandi.co.nz>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] net/dccp/: possible cleanups
Cc: acme@mandriva.com, dccp@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060628165430.GM13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060628165430.GM13915@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments below:

On 6/29/06, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains the following possible cleanups:
> - sysctl.c: the Kconfig rules already disallow CONFIG_SYSCTL=n,
>             there's no need for an additional check
Agree

> - proper extern declarations for some variables in dccp.h
NAK - have sent another patch to shift these to feat.h. Arnaldo is
reviewing patches next week.

> - make the following needlessly global function static:
>   - ipv4.c: dccp_v4_checksum()
Agree

> - #if 0 the following unused functions:
>   - ackvec.c: dccp_ackvector_print()
>   - ackvec.c: dccp_ackvec_print()
>   - output.c: dccp_send_delayed_ack()

NAK on the first two. These are for debugging and DCCP still needs
improving so I think worthwhile having there in short term so we can
quickly call them if needed.

I will leave Arnaldo or Andrea to comment on last one...

Ian
-- 
Ian McDonald
Web: http://wand.net.nz/~iam4
Blog: http://imcdnzl.blogspot.com
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand
