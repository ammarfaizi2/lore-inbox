Return-Path: <linux-kernel-owner+w=401wt.eu-S1030449AbXAHCYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbXAHCYJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 21:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbXAHCYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 21:24:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:42209 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030449AbXAHCYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 21:24:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=os0ZE8Z7tQ4UtZZmFOssoVZ7lTt/H0lwbetmHsgvPTOs0FqvJDY11IIQerd6Eab7upqSW0Xtuo+UgvjPJAB3X8pBRWtk6SrHDDmFuxS1OYbujbRcGen2clCKF43BgFboLZNTIksxWRdOGbzz7A37Yeiks/ymW+0CYmbRAQjitPs=
Message-ID: <45A1AB3F.1080408@gmail.com>
Date: Mon, 08 Jan 2007 11:23:59 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Pablo Sebastian Greco <lkml@fliagreco.com.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems
References: <459A674B.3060304@fliagreco.com.ar> <459B9F91.9070908@gmail.com> <459BC703.9000207@fliagreco.com.ar> <459C8A5E.5010206@gmail.com> <459CFE7B.6090306@fliagreco.com.ar> <459DC2EE.1090307@fliagreco.com.ar>
In-Reply-To: <459DC2EE.1090307@fliagreco.com.ar>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Sebastian Greco wrote:
> After an uptime of  13:34 under heavy load and no errors, I'm pretty
> sure your patch is correct. Is there a way to backport this to 2.6.18.x?

I forgot this (even though I implemented it) but you can turn off NCQ by
doing the following.

# echo 1 > /sys/block/sdX/device/queue_depth

Can you put the seagate drive under load to verify that it's the samsung
drive's problem not the controller's?

> Just an off topic question, does anyone know why I get so uneven IRQ
> handling on 2.6.19-20 and almost perfect on 2.6.20-rc2-mm1?

I dunno.  You have much better chance of getting a useful answer by
asking it on a separate thread with proper subject line.  People usualyl
screen threads by subject.  There are just too many message in LKML for
anyone to follow all the message.

Thanks.

-- 
tejun
