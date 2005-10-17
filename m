Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVJQV2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVJQV2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVJQV2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:28:07 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:58834 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S932338AbVJQV2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:28:06 -0400
Date: Mon, 17 Oct 2005 23:28:01 +0200
To: linux-kernel@vger.kernel.org
Subject: Let this uinput patch go to 2.6.14
Message-ID: <20051017212801.GA24482@tink>
References: <20051015212911.GA25752@tink> <20051016211252.GA21557@tink> <20051016220606.GA30260@tink> <200510170055.47342.dtor_core@ameritech.net> <courier.43534FD3.00004F78@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <courier.43534FD3.00004F78@softhome.net>
User-Agent: Mutt/1.5.9i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 01:16:35AM -0600, emard@softhome.net wrote:
> >-	complete(&request->done);
> >-
> > 	/* Mark slot as available */
> > 	udev->requests[request->id] = NULL;
> > 	wake_up_interruptible(&udev->requests_waitq);
> >+
> >+	complete(&request->done);

I have tested this quite thoroughly, 
no crash no leakage in effect slots,
I'd like to have this in 2.6.14
