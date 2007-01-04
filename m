Return-Path: <linux-kernel-owner+w=401wt.eu-S1030202AbXADVXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbXADVXi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbXADVXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:23:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:7378 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030202AbXADVXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:23:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sy70xlnglkx6IP7+eCjC0Nb+uSKybs15PKXjH+5qp6ovXx6ZbqT92G6v0e0/ruf4O+NYnzQY/mniR88t+4yHZ5l3eAOkFEVDsn2w7ky643kZSLS4L7C3EY1sazwvEMoIF6cy/LZ4Mg2lqDsNPdOS4GKFBtoib6hzK/IsKcHs/N8=
Message-ID: <84144f020701041323m6a16420ak1f76fcc3e37763ce@mail.gmail.com>
Date: Thu, 4 Jan 2007 23:23:35 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH] slab: cache alloc cleanups
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
In-Reply-To: <20070104211543.GA21917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
	 <20070104211543.GA21917@lst.de>
X-Google-Sender-Auth: 76ac76f66768c0aa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/07, Christoph Hellwig <hch@lst.de> wrote:
> Seems to work nicely on my 2node cell blade.

Thanks for testing. Unfortunately as the other Christoph pointed out,
my patch reintroduces a bug that was fixed a while ago. kmalloc_node
should not be using mempolicies...
