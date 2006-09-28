Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWI1UqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWI1UqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWI1UqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:46:10 -0400
Received: from gw.goop.org ([64.81.55.164]:28594 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750787AbWI1UqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:46:08 -0400
Message-ID: <451C349B.9020102@goop.org>
Date: Thu, 28 Sep 2006 13:46:19 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 24 of 28] IB/mthca - Fix compiler warnings with gcc4 on
 possible unitialized variables
References: <9fa624c592af68f7a851.1159459220@eng-12.pathscale.com> <adaslib5057.fsf@cisco.com>
In-Reply-To: <adaslib5057.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> NAK -- I don't want to generate worse code to fix a compiler warning
> false positive.
>   

Maybe we should have a "make defined" operation for this kind of thing:

    #define DEFVALUE(x)   asm("" : "=rm" (x))

Which is pretty ugly, I admit...

    J
