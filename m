Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWCFHjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWCFHjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWCFHjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:39:55 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:29647 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750928AbWCFHjz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:39:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=umM7QqQcPhWfoK5isKHiEZ0yB43PlKOPll5Gqz/MFGsIaBDymK4MADwwqOloR2XMA0/NQKUkbaE8B0//RDdFKYak45Bn2ryibNUf700y9DBlJK5PhFj2Jb8Y0bxclgj7axgygr12ikSw9CiwI1IfR3zpl2N8g3l2mRqPs0c+CaU=
Message-ID: <661de9470603052339s42a9b72bqcef489bddb296803@mail.gmail.com>
Date: Mon, 6 Mar 2006 13:09:54 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Balbir Singh" <bsingharora@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
In-Reply-To: <20060306073121.GG21445@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306070456.GA16478@redhat.com>
	 <20060305.230711.06026976.davem@davemloft.net>
	 <661de9470603052326i5f4a6a7q79bc370d180737b1@mail.gmail.com>
	 <20060306073121.GG21445@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The vast majority of people never run with slab poisoning enabled
> judging by the number of bugs it constantly turns up.
>

Agreed, maybe we could insist that developers enable these options and
test their patch with debugging enabled before posting them, but I
have a feeling that it would meet a lot of resistance :-). Doesn't
hurt to document it in Documentation/HOWTO or somewhere more
appropriate.

>  > kfree() will ignore NULL
>  > pointer, from the comments in kfree
>
> *nod*, poisoning the ptr would be a better idea.
>

Yes, I think this is a better idea.

>  > May we could have such a variant under CONFIG_DEBUG_SLAB if we needed
>  > and also change the variant kfree to BUG_ON() a NULL pointer.
>
> given the cost is just a ptr assignment in a slow path, I'd prefer
> it was non-optional, otherwise it'll be as underused as the other
> debugging options.
>

Yes, agreed.
