Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWBTOVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWBTOVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWBTOVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:21:41 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:12381 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964935AbWBTOVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:21:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=H7/IFJkgKfQPI6X5e+HtS2UoBOM++dvIWXzuW7G/j5Gb6cJp2PImxeCBJuHu+b7o54brZ+/IJ2ubcamFDdKUJ5evXb3MPHPNbRZWS3lWaRwgPzuhABDjTl8TDPJwIjYLr49z3HT61MKcWOAltk1Cbin68zS3RUXhVeuynfCVBLI=
Message-ID: <43F9D071.5000409@gmail.com>
Date: Mon, 20 Feb 2006 23:21:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jfeise@feise.com
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Kernel oops: 2.6.16-rc3-mm1 dvd mount
References: <43F4A5FE.3080601@feise.com> <43F96743.9050103@gmail.com> <43F9CF85.1020500@gmail.com>
In-Reply-To: <43F9CF85.1020500@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Tejun Heo wrote:
> 
>> This oops happened because get_request() was invoked with NULL @q.  It 
>> seems like SCSI midlayer refcounting mixup.  I'll dig deeper and 
>> report again as soon as I can find something concrete.
> 
> 
> Hello, all & James.
> 
> I've bisected the patch series and the winner is #221 
> git-scsi-misc.patch which seems to contain eight commits. I think SCSI 
> people can hunt this down from now on. The bug happens whenever sr block 
> device is accessed - mount, cat, whatever, and now it seems like some 
> kind of data overrun.
> 

Oops, I snipped all important information. The original thread is

http://article.gmane.org/gmane.linux.kernel/379968

Sorry.

-- 
tejun
