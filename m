Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVENXC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVENXC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 19:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVENXC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 19:02:56 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:51535 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261450AbVENXCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 19:02:55 -0400
Message-ID: <4286839A.2090302@tls.msk.ru>
Date: Sun, 15 May 2005 03:02:50 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
References: <20050506212227.GA24066@kroah.com>
In-Reply-To: <20050506212227.GA24066@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
[]
> Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> USB hotplug program can be written with a simple one line shell script:
> 	modprobe $MODALIAS

Speaking of which.. may I suggest this:

   if [ ! -L /sys/$DEVPATH/driver ]; then
      modprobe $MODALIAS
   fi

instead?  Hopefully, thanks to previous patches in this area, the sysfs
directory has already been populated properly at a time of the hotplug
event, right?

/mjt
