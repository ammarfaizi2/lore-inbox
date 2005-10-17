Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVJQHQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVJQHQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVJQHQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:16:36 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:33411 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S1751062AbVJQHQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:16:36 -0400
References: <20051015212911.GA25752@tink>
            <20051016211252.GA21557@tink>
            <20051016220606.GA30260@tink>
            <200510170055.47342.dtor_core@ameritech.net>
In-Reply-To: <200510170055.47342.dtor_core@ameritech.net> 
From: emard@softhome.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uinput crash maybe this is the FIX
Date: Mon, 17 Oct 2005 01:16:35 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [83.131.64.233]
Message-ID: <courier.43534FD3.00004F78@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	complete(&request->done);
> -
>  	/* Mark slot as available */
>  	udev->requests[request->id] = NULL;
>  	wake_up_interruptible(&udev->requests_waitq);
> +
> +	complete(&request->done);

Man, I think that's the way to go!
I will continue testing with this
patch, so far it looks good :) 

