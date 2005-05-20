Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVETIxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVETIxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 04:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVETIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 04:53:06 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:55668 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261383AbVETIxC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 04:53:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N9cTBSzZM99/32xLRtKkebAV7XvDAhKru3dtbsnX6T5p1zOmkf8tm3s5YxkdPPaAsO/Uh9E8TBLj0S5m5u/kr4hRcAXkP0nuUsPv3X+7n5/QiGspF/cxfP7YJ4V/KKxNoGy3Nwgg1LznL8zXkpYzmn4RZquxIuKCCq2MsKyjeTM=
Message-ID: <25381867050520015339f02e9b@mail.gmail.com>
Date: Fri, 20 May 2005 04:53:02 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Cc: greg@kroah.com, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <v0eBIb5C.1116575188.8501740.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050519213551.GA806@kroah.com>
	 <v0eBIb5C.1116575188.8501740.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/05, Jean Delvare <khali@linux-fr.org> wrote:
> 
> Hi Greg,
> disabled. While this feature was almost not used so far, I think we
> should have the driver not create interface files for disabled inputs.
> In the case of temperature channels which can be dynamically enabled and
> disabled. it would even make sense to dynamically create and delete
> related sysfs files. Doing so would allow for memory savings and would
> also be less error-prone for the user (presenting an interface for
> disabled features is quite confusing IMHO).

If you think more than a few hwmon/chip drivers will benefit from
dynamically creating the attributes, then maybe we can create some
standard method for doing so, bmcsensors of course needs to
dynamically allocate things, so I'd be using them too.

An earlier idea was to create a standard sysfs function(s) for
dynamically creating device_attributes (and others), but now we will
have custom structures with an embedded device_attribute, it looks to
me like each attribute type would require it's own function.

Yani
