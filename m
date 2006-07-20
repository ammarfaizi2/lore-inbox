Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWGTI1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWGTI1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 04:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWGTI1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 04:27:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:18308 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964906AbWGTI1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 04:27:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VV3oujKXMrs6x/Kk2Q0W2kX1R8OCXry1xMbmHGtsWLSgJzMvoEVdXO7G0YJ/FmOB4UPuKUmhvBJ//yJlEzAnVTzUAwroZUCel5+6+nIRS8g8VmgoWhPl1NyhRIkXNzQSoxbMYBZ2CyqikGgwq6TqVDovjZLKS0s0PTdSCrdDvKQ=
Message-ID: <9a8748490607200127r40ad4e66iffa3a6efb6f9f06c@mail.gmail.com>
Date: Thu, 20 Jul 2006 10:27:13 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: Subbu <subbu@sasken.com>
Subject: Re: Memory allocation Failure problem with kmalloc.
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       subbu2k_av@yahoo.com
In-Reply-To: <Pine.GSO.4.64.0607201340580.13879@sunm21.sasken.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com>
	 <Pine.GSO.4.64.0607171557040.15797@sunm21.sasken.com>
	 <Pine.GSO.4.64.0607201340580.13879@sunm21.sasken.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/06, Subbu <subbu@sasken.com> wrote:
>
>
> Hi,
>
>    I am working on 2.4.20 kernel.
>
>    I need to allocate memory with kmalloc.
>
>    kmalloc fails because i want to allocate more than 128kb. How to handle
> this issue.
>
>    Please help me in this regard.
>
>    How i can allocate memory of size equal to 1Mb with kmalloc or any other
> function (2.4 kernel)
>
kmalloc() allocates physically contiguous pages. 1M is a hell of a lot
of contig pages to ask for. I doubt you can get that much except at
early boot. But, if the pages don't actually need to be physically
contiguous, then you can use vmalloc() - it'll give you a virtually
contiguous range but the pages are not nessesarily physically
contiguous.

Why do you need this much btw?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
