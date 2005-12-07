Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVLGPtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVLGPtq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVLGPtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:49:46 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:14092 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751155AbVLGPtp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:49:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U3FLJfhzVUlDqg9jP7Lg6whJBybhCq4GHmP/cR3vijUC7yiGJzCbjJsvsn49hqtPqw+pyRPsOWBaFLLgKnQ3mV/ijlpbn+uUam20T7Ch5o1+tuc8sfQz6W91S1gNpQ//+PThgjoBKDlXrFz/FRfDeRorjLpAk8Te/wuD+KEbikg=
Message-ID: <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
Date: Wed, 7 Dec 2005 16:49:41 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <1133970074.544.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-12-07 at 15:45 +0100, Bartlomiej Zolnierkiewicz wrote:
> > OK, I understand it now - when using 'ide-generic' host driver for IDE
> > PCI device, resume fails (for obvious reason - IDE PCI device is not
> > re-configured) and this patch fixes it through using ACPI methods.

I was talking about bugzilla bug #5604.

> Even in the piix case some devices need it because the bios wants to
> issue commands such as password control if the laptop is set up in
> secure modes.

I completely agree.  However at the moment this patch doesn't seem
to issue any ATA commands (code is commented out in _GTF) so
this is not a case for bugzilla bug #5604.

Bartlomiej
