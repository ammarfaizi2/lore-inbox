Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965938AbWKTP71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965938AbWKTP71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965970AbWKTP71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:59:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:928 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965938AbWKTP70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:59:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BAp1degyPiHBoGJXfXfYkaQQuYBimQrUOMFvSClqGmMD9k1eNieSncK4fUukcwBAQbscPwCU/4V0P+yGDhciDkojw9GvX4zR5ASBNNmrtj3iYgnQxwc9VrR4YwTH2/TEpl1yTXDtKw9L/xjyBNcf5xPs2pZlp9GD2RID6coHuv8=
Message-ID: <86802c440611200759t6c6bbac9od4a3837a05906760@mail.gmail.com>
Date: Mon, 20 Nov 2006 07:59:19 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: yadviga <yadviga@ru.mvista.com>, "Greg KH" <gregkh@suse.de>,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] large pci adress space in pci/probe.c for linux-2.6.18
Cc: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
In-Reply-To: <4561CBF9.CA21F786@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4561CBF9.CA21F786@ru.mvista.com>
X-Google-Sender-Auth: 81422cf3be452c97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/06, yadviga <yadviga@ru.mvista.com> wrote:
> This is a request from Cisco to update pci address space for 64-bit mips
> Cavium Octeon.
>
> The size returned by a 4GB or greater sized BAR register returns zero
> which made the algorithm in pci_read_bases() hit a continue instead of
> continuing to read the upper 32-bits of the address space. I needed to
> add the code to check if it was a 64-bit memory space by checking the
> relevant lower bits, in which case the lower 32-bits of the size are
> 0xffffffff by the way they calculate size. As far as I can tell this has
> still not been fixed in the latest release of Linux which is 2.6.18. I
> guess no one has
> encountered such a large BAR register yet.
>

There is one version and it is G HK tree. and Adrew has cleaned that code.

for AMD K8 system with co-processor installed in opteron socket, the
co-processor may have 4G above ram installed.

YH
