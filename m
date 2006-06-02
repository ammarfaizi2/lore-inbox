Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWFBAna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWFBAna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWFBAna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:43:30 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:9250 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750997AbWFBAn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:43:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GJqt8t/xgZkEOt+bOg+HvqLedYbbK0TlsOwr4bILQFVSUr9CvD7zBsncJzk0pi4QeUsvaRfKqMJySvJabOYMd9JrrAACRniPJsjt8kfqIg5mhwfd3hZI2ofT8xbiDcHf8kffEq+uEufHUbQb0HKWYwL1fL9VMZP+YsBJPIGH+Sk=
Message-ID: <986ed62e0606011743g23278ad5gfa9f98b88a739d22@mail.gmail.com>
Date: Thu, 1 Jun 2006 17:43:27 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com
In-Reply-To: <20060601172816.78f8839b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
	 <986ed62e0606011532kdeba801l57c1867c54b2be87@mail.gmail.com>
	 <20060601155250.7dbcc6ef.akpm@osdl.org>
	 <986ed62e0606011707m11f82b7i712452236ea06cfb@mail.gmail.com>
	 <20060601172816.78f8839b.akpm@osdl.org>
X-Google-Sender-Auth: 9b52af94c897fd5e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 1 Jun 2006 17:07:29 -0700
> "Barry K. Nathan" <barryn@pobox.com> wrote:
>
> > On 6/1/06, Andrew Morton <akpm@osdl.org> wrote:
> > > Please send `grep SCSI .config'.
> >
> > Ok, here it is.
> >
> > # CONFIG_SCSI_TGT is not set
> > CONFIG_SCSI_SRP=m
>
> yup, that's the problem, thanks.

Looking at the Kconfig help text, it looks to me like SCSI_SRP without
SCSI_TGT makes no sense. I guess at some point I must have been
thinking "I have no idea what SCSI RDMA Protocol is, so I'll build it
as a module just to be safe" -- I somehow missed the word "target" in
its Kconfig help text when I enabled it...
-- 
-Barry K. Nathan <barryn@pobox.com>
