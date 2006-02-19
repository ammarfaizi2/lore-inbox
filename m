Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWBSC5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWBSC5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 21:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWBSC5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 21:57:17 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:62158 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750746AbWBSC5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 21:57:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=N7JRuTWm4qWArfoZ7XK9YotdRnxdlW9Oo1M03S0Cn2UJxykyEiuoPrGBsW7euvW4SCEOPbKV3RcZmrWMgPh34b1k7g3nhkkO1RPXeoSrolQVC56T20jnfIm/rkXX8x7XAGtizlvgJ2Rpj/1eWgO38wlnLPqUCzOTXj1GAOqjd28=
Date: Sun, 19 Feb 2006 06:57:16 +0200
From: Sasha Khapyorsky <sashakh@gmail.com>
To: s.schmidt@avm.de
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, kkeil@suse.de,
       linux-kernel@vger.kernel.org, opensuse-factory@opensuse.org,
       libusb-devel@lists.sourceforge.net
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060219045716.GA9880@khap>
References: <20060205205313.GA9188@kroah.com> <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:24 Thu 16 Feb     , s.schmidt@avm.de wrote:
> We are pleased to note that the GPL_EXPORT_SYMBOL fix has been withdrawn.
> This is particularly important for customers who have been relying on good
> driver coverage for ISDN/DSL devices with SUSE distributions over the past
> few years. However, as we understand the ongoing discussion, a number of
> people are tending towards a position of enforcement of USB GPL drivers
> only. We would like to take this opportunity to clarify where we see the
> differences between AVM and other devices and the difficulties regarding a
> possible move towards user mode.
> 
> The user space does not ensure the reliability of time critical analog
> services like Fax G3 or analog modem emulations. This quality of service
> can only be guaranteed within the kernel space.

Soft modems may work pretty well in userspace - slmodem is example.

Real-time requirement for V.34 is 40ms response time and only once during
the session when echo canceller parameters are negotiatiated (so you may
decrease "buffer size" before and increase after - there are enouph
silence places for such manipulations). Fax itself does not require any
"realtime" AFAIK, other place is almost unused today V.32 - 26ms, also
for echo canceller setup.

Regards,
Sasha.
