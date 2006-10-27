Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWJ0SzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWJ0SzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbWJ0SzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:55:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:15642 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750892AbWJ0SzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:55:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=F06Glo1yI7Iy6LXnEcK4fdGgOxzsitZJ+YuJ7hks/4BPNycjJMru7E+JnvBzz5csNZ/wAvSA/RnsE8vpp4rAd8VB5uKLJFPCajEpp9FMVv71ANt7ZypMMOzVbaRbtao0PxhwTeS2Uw1JVEmtQVqGtWRqcfLSIjrZSGtSFdpKASY=
Message-ID: <f46018bb0610271155kaccbf61p86b590a9c1580b06@mail.gmail.com>
Date: Fri, 27 Oct 2006 14:55:07 -0400
From: "Holden Karau" <holden@pigscanfly.ca>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes in fat_mirror_bhs [really unmangled]
Cc: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, holdenk@xandros.com,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4540AA20.1090005@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4540A32E.5050602@pigscanfly.ca> <4540AA20.1090005@yahoo.com.au>
X-Google-Sender-Auth: 85e07d61b72f8b28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on some rather off-the cuff bench marking I've done I get around
a 5 to 10% performance improve over the stock 2.6.18.1 performance. As
the saying goes, there are lies, damn lies, and bench marks, so YMMV.

On 10/26/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Holden Karau wrote:
> > From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
> >
> > This is an attempt at improving fat_mirror_bhs in sync mode [namely it
> > writes all of the data for a backup block, and then blocks untill
> > finished]. The old behaviour would write & block in smaller chunks, so
> > this should be slightly faster. It also removes the fixme requesting
> > that it be fixed to behave this way :-)
> > Signed-off-by: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
>
> So how much is performance improved?
>
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>


-- 
Cell: 613-276-1645
