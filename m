Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWGSIaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWGSIaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWGSIaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:30:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:31733 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932521AbWGSIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:30:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=raffRbSbzohUWUMZ+WEyBf4yXxhZ7/2OFgm3Q9xSuJl+9MOwnVCe6vVkn/GEu/RPJsGtdIsEug2j3FFOph1/ZcSfvAPHoe/4Ei3VYiD6H8GffheCH1BeYHtPXbGM3oj6YxZW8NmQG3P6JfrgQAVWKxPqqtVChS3AkwZmumMdXZE=
Message-ID: <84144f020607190130q94b5563i436e16028eb9fb94@mail.gmail.com>
Date: Wed, 19 Jul 2006 11:30:17 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "yunfeng zhang" <zyf.zeroos@gmail.com>
Subject: Re: Improvement on memory subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4df04b840607182021hecef3b6v24c4794444a8e53c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
	 <84144f020607180925s62e6a7abvbaf66c672849170b@mail.gmail.com>
	 <4df04b840607182021hecef3b6v24c4794444a8e53c@mail.gmail.com>
X-Google-Sender-Auth: b7e31ab16085208a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/06, yunfeng zhang <zyf.zeroos@gmail.com> wrote:
> > > 3. All slabs are all off-slab type. Store slab instance in page structure.

2006/7/19, Pekka Enberg <penberg@cs.helsinki.fi>:
> > Not sure what you mean. We need much more than sizeof(struct page) for
> > slab management. Hmm?

On 7/19/06, yunfeng zhang <zyf.zeroos@gmail.com> wrote:
> Current page struct is just like this

[snip]

Which, like I said, is not enough to hold slab management structures
(we need an array of bufctl_t in addition to struct slab).
