Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWHVL3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWHVL3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWHVL3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:29:47 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:21116 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932136AbWHVL3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gR/FHvjio8qQf2tPsGTSF4+aw8xkd8vDaGLejteApAw2tKQu7hrmte/kX7jB1UFtH5+/juDUdvMylogRq2hK2cSyMwIjarOJnGt8IIrgcYT+z+AvXTlShwitN9KIkh44hLYD7BavE1DKqiAjohhAUS6TG0lPaYJEQ7smq0jBFSo=
Message-ID: <6278d2220608220429w7209eae1g26b29315604e3518@mail.gmail.com>
Date: Tue, 22 Aug 2006 12:29:46 +0100
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Thomas Glanzmann" <sithglan@stud.uni-erlangen.de>
Subject: Re: sky2 doesn't receive any packages after I ssh in via ipv6 and edit a file in vim (reproducable)
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060822111659.GE18587@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6278d2220608220228x46010973p52bd4eeac34113@mail.gmail.com>
	 <20060822104130.GC18587@cip.informatik.uni-erlangen.de>
	 <6278d2220608220412s3df3a1c1wc9e3a3daab9c8555@mail.gmail.com>
	 <20060822111659.GE18587@cip.informatik.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Glanzmann wrote:
> Hello,
> I have the newest sky2 driver (with the newest fix in version 1.5)
> running on my intel mac mini running under legacy bios modus. However if
> I ssh in via IPv6 and start vim in the shell to edit a file the sky2
> network adapter stops to work. This is reproducable. A friend of mine
> thought that maybe the IPv6 code doesn't request the right checksum. But
> I have no clue if it is related to this. I can give access to the
> machine via ssh (including root) if someone is willing to track this
> down. I have a userland programming running which reboots the machine if
> the network connectivity is lost. At least this one is reliable. If
> noone wants a shell account maybe someone can guide me through
> debugging and tracking this down.
>
> (mini) [/var/log] grep sky2 kern.log
> Aug 20 20:52:10 mini kernel: sky2 v1.5 addr 0x90200000 irq 17 Yukon-EC (0xb6) rev 2
> Aug 20 20:52:10 mini kernel: sky2 eth0: addr 00:16:cb:a3:91:3c
> Aug 20 20:52:12 mini kernel: sky2 eth0: enabling interface
> Aug 20 20:52:12 mini kernel: sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
> Aug 20 21:01:34 mini kernel: sky2 eth0: hw error interrupt status 0x30
[snip]

I am experiencing other sky2 issues which I can workaround by:

# ethtool -K eth0 rx off

It would be interesting if you can see if this, or other features being
disabled works around your issue, eg:

# ethtool -K eth0 tx off
and:
# ethtool -K eth0 txo off

Dan
--
Daniel J Blueman
