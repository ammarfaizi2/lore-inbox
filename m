Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWJFAxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWJFAxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWJFAxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:53:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:49260 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932513AbWJFAxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:53:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mViaR+bwcdEiHrywMG9hX/AwW5unxCj1XyeeT/mI5jFIaPhZY9hcbPOpmFXR+j5Se0xFD3FrL+bmQMXS/tSgIeDt9jWe21wyA7VenzzDtSnkUGQlDE8oRlmkj32fILA+SSA/PCavi8YchesjBj/4uzBG9DjKjpBE0oC2qYGBWXA=
Message-ID: <513a5e60610051753o1dd828c4i52b8ba563601694a@mail.gmail.com>
Date: Thu, 5 Oct 2006 19:53:02 -0500
From: "Madhu Saravana Sibi Govindan" <ssshayagriva@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Using "Asynchronous Notifications" within an interrupt handler
In-Reply-To: <513a5e60610051727t7f7c7b78u62410c4b8f8502a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <513a5e60610051727t7f7c7b78u62410c4b8f8502a7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm developing a linux device driver for kernel version 2.16.15. I'm
thinking of using the "Asynchronous Notification" mechanism, explained
in the Linux Device Drivers book by Corbet and Rubini in Chapter 6,
within an interrupt handler.

The idea is: whenever the device driver receives an interrupt from the
hardware device, the interrupt handler uses this 'asynchronous
notification' mechanism to notify a user-level process of this
interrupt. The user-level process, on the other hand, is waiting for
this SIGIO signal from the device driver.

My question is: is it safe to use the asynchronous notification
mechanism within an interrupt handler? I see that this call acquires a
bunch of locks before sending the signal to the process. Would this
cause any deadlocking situations? Or should I resort to the top and
bottom half approach for interrupt handling and handle the
notification in the bottom half?

I'd be very thankful for suggestions/ideas on this topic.

Regards and thanks in advance,
G.Sibi

PS: I've posted this to os_drivers@lists.osdl.org too. My apologies
for the duplication.
