Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVAaAyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVAaAyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 19:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVAaAyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 19:54:23 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:62277 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261872AbVAaAyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 19:54:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iROjlbT4v0gVPrSiDl0VP55k+Cql+FhWp448js6RLAJxkqDjaWn8+hZxru5bUnGR8ieDa7aavqTNsKj8ATkwvj6jCrku2XDWs5ttmbsJY9zph/BXI5fmaYk9N/cl1/Nc5HF6kFdCBNAgcPGQutpi05x4CHnW/9OG1eWquyLlLSw=
Message-ID: <9e4733910501301654306c0d87@mail.gmail.com>
Date: Sun, 30 Jan 2005 19:54:19 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: inter-module-* removal.. small next step
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
In-Reply-To: <1107132112.783.219.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050130180016.GA12987@infradead.org>
	 <1107132112.783.219.camel@baythorne.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 00:41:52 +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sun, 2005-01-30 at 18:00 +0000, Arjan van de Ven wrote:
> > Hi,
> >
> > intermodule is deprecated for quite some time now, and MTD is the sole last
> > user in the tree. To shrink the kernel for the people who don't use MTD, and
> > to prevent accidental return of more users of this, make the compiling of
> > this function conditional on MTD.
> 
> Please get the dependencies right -- it's not core MTD code, but the NOR
> chip drivers and the old DiskOnChip drivers which use this.

Are these things old enough to just be marked broken instead and
finish removing inter_xx?

-- 
Jon Smirl
jonsmirl@gmail.com
