Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932842AbWF1Pre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbWF1Pre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbWF1Prd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:47:33 -0400
Received: from gw.goop.org ([64.81.55.164]:13231 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932842AbWF1Prd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:47:33 -0400
Message-ID: <44A2A396.4000202@goop.org>
Date: Wed, 28 Jun 2006 08:43:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, apw@shadowen.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org> <20060628034215.c3008299.akpm@osdl.org>
In-Reply-To: <20060628034215.c3008299.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> This is caused by the vsprintf() changes.  Right now, if you do
>
> 	snprintf(buf, 4, "1111111111111");
>
> the memory at `buf' gets [31 31 31 31 00], which is not good.
>
> This'll plug it, but I didn't check very hard whether it still has any
> off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..
>   
Damn.  This patch doesn't look right; the intent is that 'end' point to 
just beyond the formatted string.  I'm pretty sure I tested this, since 
its the most obvious test.  Clearly not enough.  I'll look into it.

    J

