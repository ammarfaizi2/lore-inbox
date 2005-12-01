Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbVLABLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbVLABLy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 20:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVLABLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 20:11:54 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:27209 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751383AbVLABLy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 20:11:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aDo0kAZAifO7oGOFrTqRvYOsJAQL6M0jbBGIg5tq+1cPwQ31ECChwq32YeVWYPeSMBUmppUPu0VIjZHBT8RNtIV4xq73ZjurO/u7oqkcrHCULeD/uO1v1Lu2msydzOfjtLN3oFUj6TrrQb8yrVSDTl5jUi5971HTBUl9z+5d0X4=
Message-ID: <69304d110511301711s2ade7fd6p667c1f160121967@mail.gmail.com>
Date: Thu, 1 Dec 2005 02:11:52 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] elevator: indirect function calls reducing
Cc: Christoph Hellwig <hch@infradead.org>, leonid.i.ananiev@intel.com,
       axboe@suse.de, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <6694B22B6436BC43B429958787E45498E7877C@mssmsx402nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6694B22B6436BC43B429958787E45498E7877C@mssmsx402nb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/05, Ananiev, Leonid I <leonid.i.ananiev@intel.com> wrote:
> Christoph,
> During that function calls 3 memory ridings are performed under
> spin_lock and having cache miss/conflict problem;
> and 2 only main memory ridings after patching.
>
> In a source a[b][c][d](arg);
> after patching number of memory ridings less by 1:
> a[c][d](arg);
> Do you agree with it?
> Have you other explanation of performance degradation 2.6.9 -> 2.6.10?
>
> Leonid
>

Leonid, you are "just" removing a memory fetch by embeding the struct
instead of pointing to it, not removing a whole indirect jump...
granted it's good to remove innecesary mem-fetchs, but then please
call the patch that, a removal of not-necessary mem-fetches.

>
> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Wednesday, November 30, 2005 7:26 PM
> To: Ananiev, Leonid I
> Cc: linux-kernel@vger.kernel.org; axboe@suse.de
> Subject: Re: [PATCH 1/1] elevator: indirect function calls reducing
>
>
> this _still_ isn't an indirect function call reduction and people
> have told you N times.  Please get your basics right first, to start
> with the patch description.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
