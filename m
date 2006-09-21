Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWIUQ1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWIUQ1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWIUQ1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:27:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:59008 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751309AbWIUQ13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:27:29 -0400
Date: Thu, 21 Sep 2006 09:27:19 -0700
From: Greg KH <greg@kroah.com>
To: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.17.11] xpad: dance pad support
Message-ID: <20060921162719.GA30691@kroah.com>
References: <4512AD76.4070005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4512AD76.4070005@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 11:19:18AM -0400, Adam Buchbinder wrote:
> From: Dominic Cerquetti <binary1230@yahoo.com>
> 
> Adds support for dance pads to the xpad driver. Dance pads require the
> d-pad to be mapped to four buttons instead of two axes, so that
> combinations of up/down and left/right can be hit simultaneously.
> Known dance pads are detected, and there is a module parameter added
> to default unknown xpad devices to map the d-pad to buttons if this is
> desired. (dpad_to_buttons). Minor modifications were made to port the
> changes in the original patch to a newer kernel version.
> 
> Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
> ---
> This patch was originally from Dominic Cerquetti originally written
> for kernel 2.6.11.4, with minor modifications (API changes for USB,
> spelling fixes to the documentation added in the original patch) made
> to apply to the current kernel. I have modified Dominic's original
> patch per some suggestions from Dmitry Torokhov. (There was nothing
> in the patch format description about multiple From: lines, so I
> haven't added myself.)
> 
> If there's anything that could be improved about this patch, please
> lease let me know. Thanks!
> 
>  Documentation/input/xpad.txt |  117 +++++++++++++++++++++++++++--------
>  drivers/usb/input/xpad.c     |  142 +++++++++++++++++++++++++++++--------------
>  2 files changed, 189 insertions(+), 70 deletions(-)
> 
> 
> diff -uprN -X linux-2.6.17.11.orig/Documentation/dontdiff linux-2.6.17.11.orig/Documentation/input/xpad.txt linux-2.6.17.11/Documentation/input/xpad.txt

Does this patch still apply to 2.6.18?

thanks,

greg k-h
