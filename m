Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbSLJWSd>; Tue, 10 Dec 2002 17:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbSLJWSc>; Tue, 10 Dec 2002 17:18:32 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:16065 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266806AbSLJWRn>; Tue, 10 Dec 2002 17:17:43 -0500
Subject: Re: Trouble with kernel 2.4.18-18.7.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Karina <kgs@acabtu.com.mx>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF6418F.B73A93E5@acabtu.com.mx>
References: <3DF6418F.B73A93E5@acabtu.com.mx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 20:51:38 +0000
Message-Id: <1039553498.14302.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 19:33, Karina wrote:
> Hi, i've just installed kernel 2.4.18-18.7.x  (from RPM) and now it
> seems there are problems with my scsi devices.
> I have attached an adaptec scsi  AIC7XXX adapter, the system detects the
> device, but in the logs appears messages: "blk: queue c24afa18, I/0
> limit 4095Mb (mask0xfffffff)", these messages didn't appear before with
> my old kernel.

Thats a perfectly normal message. Its giving parameters for your scsi

> Also, there are another messages in the dmesg results:
> 
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter errno = 2

That one is a bit stranger. I'd have expected it to put the scsi adapter
in the initrd which apparently it hasnt

> When i try to list or do something with my tape the message: st0 block
> limits 1 - 16777215 bytes appears...

Quite normal.

So it looks like its ok. Do file the kmod: failed to exec report in
https://bugzilla.redhat.com/bugzilla however. Regardless of it not being
a problem in your case it does want fixing

