Return-Path: <linux-kernel-owner+w=401wt.eu-S932284AbXADTHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbXADTHM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbXADTHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:07:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:57705 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbXADTHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:07:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q53vZ80gQR6Rqrwr2U6deQXm82fF3qQMsKF5s35BUxA8seaXIyScHHRQVm7o3JFwo3nsvSO56ndmVo3C7WTDyNtuMjikmffDJIoWY2BNkeLtpX8fKRpvMLfzyIlz6BVEirVnLU3+2IXL5Y6OX6QLupqnpqzo3ETRfgVXXluWq/A=
Message-ID: <58cb370e0701041107n5369edfdj2efc871de0fe7d24@mail.gmail.com>
Date: Thu, 4 Jan 2007 20:07:08 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Kasper Sandberg" <lkml@metanurb.dk>
Subject: Re: BUG, 2.6.20-rc3 raid autodetection
Cc: "LKML Mailinglist" <linux-kernel@vger.kernel.org>
In-Reply-To: <1167936465.6594.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1167936465.6594.5.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> Hello.
>
> i just attempted to test .20-rc3-git4 on a box, which has 6 drives in
> raid5. it uses raid autodetection, and 2 ide controllers (via and
> promise 20269).
>
> there are two problems.
>
> first, and most importantly, it doesent autodetect, i attempted with
> both the old ide drivers, and the new pata on libata drivers, the drives
> appears to be found, but the raid autoassembling just doesent happen.
>
> this is .17, which works:
> http://sh.nu/p/8001
>
> this is .20-rc3-git4 which doesent work, in pata-on-libata mode:
> http://sh.nu/p/8000
>
> this is .20-rc3-git4 which doesent work, in old ide mode:
> http://sh.nu/p/8002

For some reason IDE disk driver is not claiming IDE devices.

Could you please double check that IDE disk driver is built-in
(CONFIG_BLK_DEV_IDEDISK=y in the kernel configuration)
and not compiled as module?

Bart
