Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTLNLzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 06:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTLNLzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 06:55:49 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:2735 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262126AbTLNLzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 06:55:47 -0500
Message-ID: <3FDC4FAB.3000509@t-online.de>
Date: Sun, 14 Dec 2003 12:55:23 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexis <alexis@attla.net.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: modules in 2.6.0-test11
References: <006501c3c1fa$e1fb8d90$0200000a@heretic>
In-Reply-To: <006501c3c1fa$e1fb8d90$0200000a@heretic>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: rPJ6ZmZv8elhD23vCo0FUIhOleTrWNmisQ4I5cVsp23elojePp9HUC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexis wrote:
> Ive compilled and installed 2.6.0-test11 on redhat 8 in order to filter
> packets based on some patterns in layer 7 (l7-filter.sourceforge.net)
> 
> So, ive installed the kernel, and installed module-init-tools-0.9.14 too.
> 
> The kernel works fine, all modules too but i have to insert them with insmod
> or modprobe, i cannot make that modules became loaded automatically.
> 
> Ive compiled the kernel with CONFIG_KMOD=Y
> 
> any help?
> 

I found this in the FAQs (on Debian):


Q) I'm using RedHat and modules don't autoload any more.
A) RedHat turns module autoloading off if /proc/ksyms isn't found.
    Change line 337 of /etc/rc.d/rc.sysinit from:

   if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then

    to

   if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then


Hope this helps.


Regards

Harri
