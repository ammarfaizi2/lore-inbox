Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbUDBRQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDBRQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:16:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41732 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264118AbUDBRQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:16:33 -0500
Date: Fri, 2 Apr 2004 18:16:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
Message-ID: <20040402181630.B12306@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
	linux-kernel@vger.kernel.org
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net> <20040402144216.A12306@flint.arm.linux.org.uk> <20040402165941.GA29046@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040402165941.GA29046@kroah.com>; from greg@kroah.com on Fri, Apr 02, 2004 at 08:59:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 08:59:41AM -0800, Greg KH wrote:
> No, this is the way it used to be, and it caused all kinds of problems
> in the past.  It was switched to use 'select' on purpose, and should
> stay that way.

It's causing problems today by preventing people from being able to
de-select SCSI for no obvious reason.

It is far less intuitive to know you have to turn off USB_STORAGE
before you can turn off SCSI than to know that you have to turn on
SCSI before you can turn on USB_STORAGE.

If you wish to keep it this way, could we either have:

(a) a note in the SCSI help text to say that the option is forced
    on by USB_STORAGE, so people know what to turn off.

or

(b) have kconfig tell you why you can't turn off the option.

Silently preventing options being turned off with no obvious reason
is a pretty major misfeature.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
