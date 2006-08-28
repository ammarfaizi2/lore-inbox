Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWH1FDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWH1FDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 01:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWH1FDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 01:03:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:63543 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932345AbWH1FDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 01:03:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rdii7ua3pb6EbEDIeJ01rHPZxsnDxp8t36pM9fTpD2HIImclrEXBcefeL3vNdPg+8sstKqaIEXa1d+yYI9MX5dklnkODvtwlnkIT73rodRHS9k6UPSBeIkO7ZoEje6XZycKMzJ4cWS1H/GzFWvI5KkciN2zZFvufmkg9aUozXPg=
Message-ID: <18d709710608272203q740962rd0c3f2a3be95138b@mail.gmail.com>
Date: Mon, 28 Aug 2006 02:03:46 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] loop.c: kernel_thread() retval check - 2.6.17.9
Cc: "Solar Designer" <solar@openwall.com>, "Willy Tarreau" <w@1wt.eu>,
       linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <20060827214141.db40620d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18d709710608232341x491b4bf6g87f74ef830a203@mail.gmail.com>
	 <20060828035556.GA27902@openwall.com>
	 <20060827214141.db40620d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, Andrew Morton <akpm@osdl.org> wrote:
> The plan is to stop using the deprecated kernel_thread() in loop altogether.
>
> Please review
>
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/kthread-convert-loopc-to-kthread.patch
>

Well, the reason behind this patch is just adding a little bit of
cleanup code (ie., cleaning the 'lo' object) to the case when the
kernel thread creation fails, regardless of what implementation
loop_set_fd() uses to accomplish this.
In fact, I think the concept it's still usable after applying the
patch you mentioned, since after changing kernel_thread() for
kthread_create(), the only cleanup code added is setting lo->lo_thread
to NULL.

Cheers,

    Julio Auto
