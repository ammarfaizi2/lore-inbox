Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263712AbSJHUcc>; Tue, 8 Oct 2002 16:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263707AbSJHUbj>; Tue, 8 Oct 2002 16:31:39 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:44448 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263706AbSJHUam>; Tue, 8 Oct 2002 16:30:42 -0400
Date: Tue, 08 Oct 2002 13:37:24 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.5.40 panic in uhci-hcd
To: Peter Osterlund <petero2@telia.com>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Message-id: <3DA34204.1030708@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.LNX.4.44.0210082025570.16233-100000@p4.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>How does 2.5.41 work for you?
>>>
>>>It seems to be fixed. Thanks.
>>
>>Heh, that's pretty funny.  There were not any uhci specific fixes in
>>2.5.41...
>>
>>Not complaining,
> 
> 
> Actually, there were. This patch is in 2.5.41.

And wouldn't have changed any oopsing behavior, I assure you.

Your panic was being caused by something else.  I saw plenty
of strange 2.5.40 behavior indicative of someone walking over
memory they didn't own, and maybe your panic was another case.


> -               sizeof(struct uhci_td), 16, 0, GFP_ATOMIC);
> +               sizeof(struct uhci_td), 16, 0);

