Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUE3E4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUE3E4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 00:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUE3E4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 00:56:34 -0400
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:25763 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S261712AbUE3E43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 00:56:29 -0400
From: Rob <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: seperate environments for different kernels
Date: Sun, 30 May 2004 00:58:28 -0500
User-Agent: KMail/1.6.2
References: <Pine.GSO.4.58.0405292206320.2487@tokyo.cc.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0405292206320.2487@tokyo.cc.gatech.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405300058.28834.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 09:13 pm, Younggyun Koh wrote:
> Hi,
>
> i want to run linux 2.6.6 kernel, which needs upgrade of some system tools
> such as module-init-tools and nfs-utils. but other guys using the same
> machine with 2.4 kernel don't want me to upgrade them.
>
> is there any way i can make different system tools installed when i boot
> with the different kernel images other than mounting root directory to the
> different partitions? (i can't create a new partition)
>
> thank you,
>
> 			-Younggyun Koh (young@cc.gatech.edu)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

i was thinking about this... my brute force idea:
make some very early init scripts manipulate a bunch of symlinks, based on the 
output of uname -r. you have a different kernel, it renames some dirs, and 
goes on as normal. in fact, you oughta be able to have a few separate init 
script kits that all run but immediately exit if their designated kernel 
isn't running, like  `uname -r`= "2.6.6-test1" || exit
 
-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
--
