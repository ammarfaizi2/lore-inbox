Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVHDR1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVHDR1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVHDRYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:24:47 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:52387 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261705AbVHDRXP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cl/+IKqmNQj+7CDB9NHcnaF0CpgGN0S6z4KQ3dQHnZBLzhkwVtX8abjvQi2LJutCckTuBLwawubgVxq0ZgkTfjs58RywEg8a1edhblMMWifgfYsqTLmuM3z3Y778WxmAokh6waV1Vt1w/MEYXTFgTL1I4AtQX2jwnutHKuZvrGM=
Message-ID: <86802c4405080410236ba59619@mail.gmail.com>
Date: Thu, 4 Aug 2005 10:23:15 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: mthca and LinuxBIOS
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <52mznxacbp.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	 <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
	 <86802c44050803175873fb0569@mail.gmail.com>
	 <52u0i6b9an.fsf_-_@cisco.com>
	 <86802c44050804093374aca360@mail.gmail.com> <52mznxacbp.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mellanox can use prefmem64, but the BIOS could only allocate the
some range below 4G, So 32 bit OS still can use the IB cards.
but for 64bit OS, We could allocate range above 4G (0xfc00000000), So
the mmio below 4G can be smaller. ( for example from 512M to 128M, the
user can get back some RAM back if Opteron don't have hardware memhole
support).

YH



On 8/4/05, Roland Dreier <rolandd@cisco.com> wrote:
> >>>>> "yhlu" == yhlu  <yhlu.kernel@gmail.com> writes:
> 
>     yhlu> YES.  I will send you the output message later about
>     yhlu> "CONFIG_INFINIBAND_MTHCA_DEBUG=y"
> 
> Thanks.  In the meantime, can you explain what it means to "enable the
> prefmem64 to use real 64 range"?  What is the difference between this
> and the configuration that works?
> 
>  - R.
>
