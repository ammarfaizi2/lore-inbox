Return-Path: <linux-kernel-owner+w=401wt.eu-S964912AbWLMNBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWLMNBZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWLMNBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:01:25 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:25767 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964927AbWLMNBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:01:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UCsx66htznhh1+YljHtLsHF1nqcb8C1BflZhj8E4Vu4P/bidKyYw3iLNm75vKgKs/0RSRN9djBg/1VK947kQGB5ua0q8PM5sG6eg8LtydsB70iflkZQZtKJ+yexlDlxiQmo1n19zUYwhhh0lABF/je9sLCGo/fKJiDw5U9dbjgY=
Message-ID: <457FBBDC.9050608@gmail.com>
Date: Wed, 13 Dec 2006 17:37:48 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Andrew Robinson <andrew.rw.robinson@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with
 SATA and should not be used by any meansis not stable with SATA and should
 not be used by any means)
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com>
In-Reply-To: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Robinson wrote:
> When I said hibernate, I did mention it was to disk, not to ram. I
> woke my computer up from work remotely using wakeonlan. When the
> computer was responsive, I started getting I/O errors and when I saw
> my kernel log I saw file corruption problems with my "/dev/sda2"
> device (which is my root file system and is one of two, the other is
> the swap partition)

sata_nv is just now receiving suspend/resume support in devel tree. 
2.6.19 sata_nv doesn't have it and STD might have worked but I wouldn't 
be surprised if it doesn't work from time to time or gets broken due to 
unrelated changes in kernel.  So, IO errors after STD are bad but kind 
of expected.  I dunno what went wrong with your fs after such IO errors. 
  Destroyed fs after some IO errors is pretty extreme tho.

So, my 5 cents is... don't do hibernation till 2.6.20 is out.

-- 
tejun

