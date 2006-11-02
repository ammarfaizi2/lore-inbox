Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752758AbWKBJKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbWKBJKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbWKBJKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:10:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:59766 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752758AbWKBJKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:10:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dCtpKhf6KP1vmg13Or8Su0753+E7PQnFWYLecFmMuszu3QMdZg/Ugf6ADkr+S1+yhxXZgZVqFw6uReTvjssAC18kxyf/4+DXmYY3EJTRc8ubb8h1THEqFCwWrsYgN/YyChx4T+0qZQWXIKztTak0z0nARj/fbY1/YIgUmFzQHRE=
Message-ID: <6278d2220611020110m34d09673yee73edd6c0c86ff@mail.gmail.com>
Date: Thu, 2 Nov 2006 09:10:11 +0000
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: zhfeng.osprey@gmail.com
Subject: Re: How to optimize system time for such case?
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FENG ZHOU wrote:
> Hello, all
> I am optimizing a compiler and I believe there is a bug in such
> compile. Currently, I have a test case, which is a scientific
> application, has a lot of system time. This is weird, because this
> case does not have many system calls. Meanwhile, compiled at another
> option, I found all the "system time" are gone! So, I assume there is
> some problem in the first one (though both binary produce correct
> result). I used some performance tuning tool and found the hottest
> address for CPU privilege level change event is: 0xa000000100001a70.
> This address is not in code or data segment. Now, I am kinda stuck
> here. My question is: how to find what this address is? Or find out
> what is the cause of the "system time"? Thanks in advance.
>
> PS: the platform is Itanium 2.
> -Feng

First question is what kernel, second is how much memory?

I recently had this experience (high system time) with some vendor
kernels with a system with 16GB of memory and 4-8GB processes. The VM
was trying to reclaim pages like crazy, but failing.
-- 
Daniel J Blueman
