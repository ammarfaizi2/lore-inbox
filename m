Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWFIBBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWFIBBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWFIBBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:01:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:6213 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965071AbWFIBBi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:01:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZvzILe+OOXtzKqnu4VAApX+VT32wkJ/hJwhYlCGlnp1zvVLNP+dQhMd8ogKf6tKdN9IoqqSN0uYPbzrlu+sWs/nDKTmypDnagjuz7JDpLI04pFcQCdewO6S5GYcfHEStwqCjMT3GKVQp4AZoaWULs1stFPuQsSHEszbAWyqbsyM=
Message-ID: <305c16960606081801y36c90049y2129e4733fa9f954@mail.gmail.com>
Date: Thu, 8 Jun 2006 22:01:38 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=" <mru@inprovide.com>
Subject: Re: Idea about a disc backed ram filesystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1x4pyvdxn4.fsf@agrajag.inprovide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200606082233.13720.Sash_lkl@linuxhowtos.org>
	 <305c16960606081548m316099awafa619bb5d0d14f0@mail.gmail.com>
	 <yw1x4pyvdxn4.fsf@agrajag.inprovide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, Måns Rullgård <mru@inprovide.com> wrote:
> "Matheus Izvekov" <mizvekov@gmail.com> writes:
>
> > My idea consisted of adding the capability to specify a device for
> > tmpfs mounting. if you dont specify any device, tmpfs continues to
> > behave the way it currently is. But if you do, once data doesnt fit on
> > ram (or some other limit) anymore, it will flush things to this
> > device. my intention was to reuse swap code for this, so you mount a
> > tmpfs passing the dev node of some unused swap device, and it works
> > just like tmpfs with a dedicated swap partition.
>
> I don't see what advantage this would have over normal tmpfs.
>
> --

The difference is that the swap device is exclusive for the tmpfs mount.
