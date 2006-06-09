Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWFIE71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWFIE71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWFIE71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:59:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:7348 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965162AbWFIE70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:59:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M2VkO8dkG7qIkn8lMzSyquJTXGiFCeslcNpV/03i8U2G7WidaXqLPVwaG/OAxA3IeSB3Qdd7sdiTFN80asaXapr9J+DTloGB/I0dfqT71ubl+G4FGZdRm2aP0VVfKs0ilD6m1cZfGE+2VhwvO9Ap0fZWRHjMpzOVXhzQ9Qxw/4A=
Message-ID: <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com>
Date: Fri, 9 Jun 2006 01:59:25 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Idea about a disc backed ram filesystem
Cc: "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200606090217.k592HNjq011090@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mizvekov@gmail.com>
	 <305c16960606081548m316099awafa619bb5d0d14f0@mail.gmail.com>
	 <200606090217.k592HNjq011090@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> tmpfs does use swap currently. Giving tmpfs a dedicated swap space is dumb,
> as it takes away the possibility of using that space for swapping when not
> in use by tmpfs (and viceversa).

The idea is not dumb per se. Maybe you want your applications to swap
to one device (or not swap at all) and a tmpfs mount to swap to
another. For me at least it would make a difference.
I dont use swap at all, have enough ram for all my processes. And ive
seen that for some workloads, setting a temporary directory as tmpfs
gives huge speed improvements. But just occasionally, the space used
in this temp dir will not fit in my ram, so in this case swapping
would be fine. The problem is, currently there is no way to enforce
this.
Ditto for the fact that, when you have many swap devices set, each
with different performances, there is no way to give priorities/rules
to enforce who uses each device.
When someone gets to implement those features, this wouldnt be needed
anymore. But that seems far away enough to justify a more immediate
workaround.
