Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWFIT1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWFIT1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWFIT1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:27:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:42582 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030445AbWFIT1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:27:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VGckMhhyNydrd1/jJ0TePeIBtRYE4Sfelr61XNpvGlnvl1yRyUP0R+mnzXAOlleZKVXVwDKR3+EQIvHizeWQuXmGgwsahPtvlelIP4KmTjQuZe3RXYhkIgYQHTGAmtZI1+U3qzU6O1jpKJXqpKJRzYp+OvVJa/EMmUEHiya2ArE=
Message-ID: <305c16960606091227w7e62003bhef576fb07d0aa95@mail.gmail.com>
Date: Fri, 9 Jun 2006 16:27:16 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Idea about a disc backed ram filesystem
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1149878633.3894.224.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mizvekov@gmail.com>
	 <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com>
	 <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
	 <305c16960606090807g6372b69dy3167b0e191b2c113@mail.gmail.com>
	 <1149878633.3894.224.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2006-06-09 at 12:07 -0300, Matheus Izvekov wrote:
> > Ok, but reality is that, even if i setup a swap partition with the
> > most lazy swapiness, it will swap my processes out. Is there a
> > pratical way to pin all processes to ram or otherwise tell the vm to
> > never swap any process? If there is, then you are right, there is no
> > point in doing this.
> >
>
> echo 0 > /proc/sys/vm/swappiness
>
> Lee

Sorry, i took a look at the code which handles this and swappiness = 0
doesnt seem to imply that process memory will never be swapped out.
