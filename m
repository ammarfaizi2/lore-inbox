Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWIAMXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWIAMXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWIAMXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:23:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:15425 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751148AbWIAMXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:23:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LNHVEwDUV20A3COv7u8LbMgPcx56kgY7Lr6pn2PtE1Sbal9cNrkb97jxpKViiaNRo5V72Zou4yaMUgcSZBEb4kAeqh5/n3r5PdCuaDgtVLqNn+8v6MqN7w54Zn/66dKgbzvz+t1HtNJcoKLOl9yaWhSEpcAG2n/lFhm6a5DSEx0=
Message-ID: <d120d5000609010523n6942d881k19c19a22ea102068@mail.gmail.com>
Date: Fri, 1 Sep 2006 08:23:43 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: RFC - sysctl or module parameters.
Cc: "Neil Brown" <neilb@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060901101001.GA13912@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <17655.38092.888976.846697@cse.unsw.edu.au>
	 <20060901101001.GA13912@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/06, Greg KH <greg@kroah.com> wrote:
> On Fri, Sep 01, 2006 at 12:02:52PM +1000, Neil Brown wrote:
>
> > Thus we could just have a module option, just add module config
> > information to /etc/modprobe.d and run
> >   modprobe --apply-option-to-active-modules
> > at the same time as "sysctl -p" and it would all 'just work'
> > whether the module were compiled in to not.
>
> Ah, you want it after the code is loaded.  That's different.
>
> Would probably work just fine, no objection from me.  Except you would
> have to hack up the module-init-tools package :)
>

This will be pretty hard to implement in general as quite a few module
parameters do not allow changing once set and so you will have to
virtually reload modules while doing your "modprobe --apply.." trick.

-- 
Dmitry
