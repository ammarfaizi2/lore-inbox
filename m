Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbVJ0Crh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbVJ0Crh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 22:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbVJ0Crg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 22:47:36 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:43012 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751550AbVJ0Crg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 22:47:36 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ak@suse.de (Andreas Kleen)
Subject: Re: Notifier chains are unsafe
Cc: sekharan@us.ibm.com, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Organization: Core
In-Reply-To: <5600736.1130346691049.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EUxn7-00081k-00@gondolin.me.apana.org.au>
Date: Thu, 27 Oct 2005 12:46:57 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Kleen <ak@suse.de> wrote:
> Am Mi 26.10.2005 02:01 schrieb Chandra Seetharaman
> <sekharan@us.ibm.com>:
> 
>> > Better would be likely to use RCU.
>>
>> RCU will be a problem if the registered notifiers need to block.
> ?
> Actually blocking should be ok, as long as the blocking notifier doesn't
> unregister
> itself. The current next pointer will be always reloaded after the
> blocking.

Blocking would be OK as long as you reference count the objects.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
