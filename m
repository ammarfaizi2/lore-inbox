Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVCRPXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVCRPXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVCRPXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:23:35 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:11793 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261629AbVCRPXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:23:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FWAuNGZDU3jaUcNpZgzQSAmC3XRMWvR+iGrifh/Ke7/R1vkIcrM/ZE7eT4FcUVj/mNuBrYQ+yH+FJqJ1l9lYE9MtqnEohr+QGRKBiEnJkOx34Fyib2XdMJzganVCsgfsl3XTmcheroZEYjC6VUszuAaZciLXnL0Z5C5c0QfcjrE=
Message-ID: <58cb370e050318072312531876@mail.gmail.com>
Date: Fri, 18 Mar 2005 16:23:27 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ide: hdio.txt update
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050311062908.GA11552@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050302235457.GA21352@htj.dyndns.org>
	 <20050303021638.GA24150@htj.dyndns.org>
	 <58cb370e05031008307a0163c1@mail.gmail.com>
	 <20050311062908.GA11552@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Mar 2005 15:29:08 +0900, Tejun Heo <htejun@gmail.com> wrote:
>  Greetings Bartlomiej,
> 
>  I've updated the following
> 
>  * in_flags modification when out_flags != 0 && in_flags == 0
>  * more than one -> one or more than one
>  * tf_{in|out}_flags -> {in|out}_flags as tf_* are in-kernel names
> 
>  I'll update the taskfile patch series after receiving your comments
> about the patches.  Also, if you have a big picture for the IDE
> driver, do you care to spill?  What I have in mind now are
> 
>  1. Completion-based taskfile (no direct ending/error handling of
>     requests), so that we can use it for specials/rw_disk/eh/etc...
>  2. Make specials (set_geometry, set_multmode...) more regular.
>  3. Do error-handling/resetting in a exception handler thread.
>     Maybe this and #2 should happen together.

Yep, this is the way to go.

>  So, please let me know what you think.  Updated patch for hdio.txt
> follows.

thanks, applied
