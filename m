Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWIZNUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWIZNUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWIZNUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:20:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:37737 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751328AbWIZNUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:20:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PYP+gqO6chTHkSDAOfDRkqLGTaJByqHGea9ThAoNvLLzXUhFGE3SxU5Ps7gWswyrJug64TfF4A2VVhAA/UkBpvl6mVIANdK/vS7j+ZKF4r0LYY7axdwjj2RjlB9zsLYGNy7NRPalsmOi3H634Lh9ZMMVYtCZ4ADiE7nV3hWkR0g=
Message-ID: <d120d5000609260620me5cf24bw83fc6d65fa7cb232@mail.gmail.com>
Date: Tue, 26 Sep 2006 09:20:17 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 26/47] Driver core: add groups support to struct device
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <11592491672052-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060926053728.GA8970@kroah.com>
	 <11592491371254-git-send-email-greg@kroah.com>
	 <1159249140339-git-send-email-greg@kroah.com>
	 <11592491451786-git-send-email-greg@kroah.com>
	 <11592491482560-git-send-email-greg@kroah.com>
	 <11592491551919-git-send-email-greg@kroah.com>
	 <11592491581007-git-send-email-greg@kroah.com>
	 <11592491611339-git-send-email-greg@kroah.com>
	 <11592491643725-git-send-email-greg@kroah.com>
	 <11592491672052-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Greg KH <greg@kroah.com> wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
>
> This is needed for the network class devices in order to be able to
> convert over to use struct device.
>

Greg,

You keep pushing out patches that merge class devices and standard
devices but you still have not shown the usefullness of this process.
Why do you feel the need to change internal kernel structures
(ever-expanding struct device to accomodate everything that is in
struct class_device) when it should be possible to simply adjust sysfs
representation of the kernel tree (moving class devices into
/sys/device/.. part of the tree)  to udev's liking and leave the rest
of the kernel alone. You have seen the patch, only minor changes in
driver/base/class.c are needed to accomplish the move.

I really disappointed that there was no discussion/review of the
implementation at all.

-- 
Dmitry
