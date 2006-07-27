Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWG0WVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWG0WVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWG0WVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:21:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:42936 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751362AbWG0WVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:21:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dxnNf8HSRUameWh9CyOMIXYw6u6cGQNuqDdeEiQAo6BlgQEutrQgAO/fqOlhJdD2Egu3qhwFo32QtL4SM5oZSyv80IpdiVV3Y8BZXYyKwibEwSpCgrYNf8txDusEAemP+8IuNJABX3Jj4cTXifVm6OadeCDWIKFXqxYofHghjKc=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Thu, 27 Jul 2006 15:21:37 -0700
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mtosatti@redhat.com
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607201044.00739.benjamin.cherian.kernel@gmail.com> <20060724230732.4fdf2bf4.zaitcev@redhat.com>
In-Reply-To: <20060724230732.4fdf2bf4.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607271521.38217.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 July 2006 23:07, Pete Zaitcev wrote:
> Anyway, please test the attached patch. Does it do what you want?

Sorry to say that it doesnt. When calling usb_get_string_simple in libusb, the 
program segfaults with the patched kernel. I believe that 
usb_get_string_simple eventually calls usbdev_ioctl.

Thanks,

Ben
