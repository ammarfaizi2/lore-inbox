Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUJGSz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUJGSz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJGSzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:55:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267826AbUJGSuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:50:12 -0400
Message-ID: <41658FDB.4070101@redhat.com>
Date: Thu, 07 Oct 2004 14:50:03 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gabor Z. Papp" <gzp@papp.hu>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
References: <200410071318.21091.mbuesch@freenet.de>	<20041007151518.GA14614@logos.cnet>	<200410071917.40896.mbuesch@freenet.de>	<20041007153929.GB14614@logos.cnet> <x67jq2bcy3@gzp>
In-Reply-To: <x67jq2bcy3@gzp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor Z. Papp wrote:
> * Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
> 
> | > > Can you check how much swap space is there available when
> | > > the OOM killer trigger? I bet this is the case.
> | > 
> | > The machine doesn't have swap.
> | 
> | Well then you're probably facing true OOM.
> | 
> | Add some swap.
> 
> There is really no way to run 2.4 without swap?
> 
> I have the same problem with nfsroot and ramdisk based setups after
> 1-2 weeks uptime.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

sure, you can run a system without swap, you just run the risk of not 
being able to start new processes, or OOM kills if your running 
processees try to allocate too much memory.  You can turn the OOM killer 
off if you like, but then you run the risk of wedging the machine.

Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
