Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269389AbUJFTnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269389AbUJFTnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUJFTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:43:37 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:22586 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S269389AbUJFTnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:43:32 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Joris van Rantwijk'" <joris@eljakim.nl>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 6 Oct 2004 12:43:27 -0700
Organization: Cisco Systems
Message-ID: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20041006193053.GC4523@pclin040.win.tue.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It may need fixing in the sense that it must point out that 
> the Linux kernel
> might not conform to POSIX in its handling of select on sockets.

Agreed.

> We now not only have "man 2 select", but also "man 3p select".
> This is the POSIX text:
> 
>        A  descriptor shall be considered ready for reading when a
>        call to an input function with O_NONBLOCK clear would  not
>        block,  whether  or  not  the function would transfer data
>        successfully. (The function might return data, an  end-of-
>        file  indication,  or  an  error other than one indicating
>        that it is  blocked,  and  in  each  of  these  cases  the
>        descriptor shall be considered ready for reading.)
> 
> As far as I can interpret these sentences, Linux does not conform.

How hard is it to treat the next read to the fd as NON_BLOCKING, even if
it's not set?

> Andries

