Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTJAR6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbTJAR6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:58:53 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:18587
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262118AbTJAR6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:58:52 -0400
Message-ID: <3F7B164B.5010506@trash.net>
Date: Wed, 01 Oct 2003 20:00:43 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Elsner <Elsner@zrz.TU-Berlin.DE>
CC: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 PPP filtering for ISDN
References: <E1A4l1Q-0001GC-FD@bronto.zrz.TU-Berlin.DE>
In-Reply-To: <E1A4l1Q-0001GC-FD@bronto.zrz.TU-Berlin.DE>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are missing CONFIG_FILTER=y/m. This is a config bug which is already 
fixed
in .23-preX, it is not possible to select CONFIG_IPPP_FILTER without 
selecting
CONFIG_FILTER anymore.

Regards,
Patrick

Frank Elsner wrote:

>drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_ioctl':
>drivers/isdn/vmlinux-obj.o(.text+0xe64e): undefined reference to `sk_chk_filter'
>drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_push_higher':
>drivers/isdn/vmlinux-obj.o(.text+0xf2e5): undefined reference to `sk_run_filter'
>drivers/isdn/vmlinux-obj.o(.text+0xf32d): undefined reference to `sk_run_filter'
>drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_xmit':
>drivers/isdn/vmlinux-obj.o(.text+0xf729): undefined reference to `sk_run_filter'
>drivers/isdn/vmlinux-obj.o(.text+0xf78e): undefined reference to `sk_run_filter'
>drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_autodial_filter':
>drivers/isdn/vmlinux-obj.o(.text+0xfcba): undefined reference to `sk_run_filter'
>drivers/isdn/vmlinux-obj.o(.text+0xfce4): more undefined references to `sk_run_f
>ilter' follow
>make: *** [vmlinux] Error 1
>


