Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVHEPZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVHEPZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbVHEPXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:23:18 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:27956 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262256AbVHEPWt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:22:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WLHsQ6+ORO6qObMzi6JXTqwsWQ+eJVggG4+PmhiF7Tne84tdOfnMiD135CF9onF3LUl7afaU1s5UORk+bY15TLg3lPO1EP3O0RtPX4ARkdwsd/mOdpayX0Mh93OtqMU1J2DaIK/ekcLGHuOtoyF+h95OzygVSMuXs20l2dNKYm0=
Message-ID: <d120d5000508050822f18c9ac@mail.gmail.com>
Date: Fri, 5 Aug 2005 10:22:48 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 8/8] ALSA: convert kcalloc to kzalloc
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <ikr7kp.i3e3jm.bv3m5oebr5lt3u19xzl3ct9yu.beaver@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ikr7kg.6lzzr6.7ocpqo9oanclt926l5vz7gkyx.beaver@cs.helsinki.fi>
	 <ikr7kp.i3e3jm.bv3m5oebr5lt3u19xzl3ct9yu.beaver@cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.
> 

Hi,

Have you seen the following in include/sound/core?

...
#define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
#define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
#define kfree(obj) snd_hidden_kfree(obj)

-- 
Dmitry
