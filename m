Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVBGQwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVBGQwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVBGQwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:52:04 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:41279 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261190AbVBGQvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:51:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LswKc0eIE7dJU81DRvFzg/yCkJAGDqbXFzean3g6SWj58B9W+QpASOokrJ1oUz+QFnYeGwbWG0X7TEkNtlOKOifSMOcwpTblwIQaQOTtZhw46+uRyB5+NZbN+ZnolVcDFpKkM2Zq7cDD4XmM8WRUTd8pbdRl7p60zcMyCma3ysA=
Message-ID: <d120d50005020708512bb09e0@mail.gmail.com>
Date: Mon, 7 Feb 2005 11:51:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: trelane@digitasaru.net
Subject: Re: [ATTN: Dmitry Torokhov] About the trackpad and 2.6.11-rc[23] but not -rc1
Cc: linux-kernel@vger.kernel.org, petero2@telia.com
In-Reply-To: <20050207154326.GA13539@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050207154326.GA13539@digitasaru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005 09:43:27 -0600, Joseph Pingenot
<trelane@digitasaru.net> wrote:
> Hi.
> 
> Sorry; I accidentally deleted my email and your response, Dmitry.  :/
> Anyhow, here is /proc/bus/input/devices
> 
> $ cat /proc/bus/input/devices
> I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
> N: Name="AT Translated Set 2 keyboard"
> P: Phys=isa0060/serio0/input0
> H: Handlers=kbd event0
> B: EV=120013
> B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
> B: MSC=10
> B: LED=7
> 
> I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> N: Name="PS/2 Generic Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0 event1
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=3
> 

Is that with -rc1 or -rc2?

Anyway, I think Inspiron 8600 has an ALPS touchpad and externded
support for it just went in in -rc2. I think if you boot with
psmouse.proto=exps you will get your mouse back (if your psmouse is
compiled as a module you'll need to add 'options psmouse proto=exps'
to your /etc/modprobe.conf).

Nonetheless it would be nice to see the data stream from the touchpad
to see why our ALPS support does not work quite right. Could you
please try booting with "log_buf_len=131072 i8042.debug=1", and
working the touchpad a bit. then send me the output of "dmesg -s
131072" (or just /var/log/messages).

Thanks!
-- 
Dmitry

P.S. I am CC-ing Peter Osterlund since he works on Synaptics/ALPS
driver as well.
