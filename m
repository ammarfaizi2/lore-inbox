Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWHPOvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWHPOvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHPOvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:51:10 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:64375 "EHLO
	asav11.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751192AbWHPOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:51:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAEvM4kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: raise_sail@163.com
Subject: Re: [linux-usb-devel] [PATCH] usb: The HID Simple Driver Interface 0.3.1 (core)
Date: Wed, 16 Aug 2006 10:51:06 -0400
User-Agent: KMail/1.9.3
Cc: Greg KH <greg@kroah.com>, liyu <liyu@ccoss.com.cn>,
       Alexey Dobriyan <adobriyan@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
References: <20060816030004.GC5206@martell.zuzino.mipt.ru> <20060816083521.GB24139@kroah.com> <44E2E20E.2070908@163.com>
In-Reply-To: <44E2E20E.2070908@163.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161051.07242.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 05:14, raise_sail@163.com wrote:
> 
> Greg KH wrote:
> > Go here:
> > 	http://vger.kernel.org/mxverify.html
> > to see how to fix this up.
> >
> >   
> That test site reply me "Apparently OK!", however, I still can not
> send/receive any mail from LKML.
> 
> Also, I will review CodingStyle. Sorry for uncleanly code.
> 

Hi,

Just an overall comment. I like the idea of simple plugins for HID but we
somehow need to allow them be built as modules and loaded on demand so
when I plug a device that needs special handling an appropriate piece
will get loaded and attached to the HID driver before my device is bound
to it. Built-ins are not very nice when you look from a distribution POV
becuase they have to enable every option and there are qute a few of devices
that need special handling. 

-- 
Dmitry
