Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbSI2OoT>; Sun, 29 Sep 2002 10:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262489AbSI2OoT>; Sun, 29 Sep 2002 10:44:19 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:51118 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262488AbSI2OoS>; Sun, 29 Sep 2002 10:44:18 -0400
To: James Morris <jmorris@intercode.com.au>
Cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH] accessfs v0.6 ported to 2.5.35-lsm1 - 1/2
References: <Mutt.LNX.4.44.0209292236200.27145-100000@blackbird.intercode.com.au>
From: Olaf Dietsche 
	<olaf.dietsche--list.linux-security-module@exmail.de>
Date: Sun, 29 Sep 2002 16:49:12 +0200
Message-ID: <87it0o4zrr.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@intercode.com.au> writes:

> On Fri, 27 Sep 2002, Greg KH wrote:
>
>> As for the ip_prot_sock hook in general, does it look ok to the other
>> developers?
>> 
>
> This hook is not necessary: any related access control decision can be
> made via the more generic and flexible socket_bind() hook (like SELinux).

AFAICS, it looks like you can make _additional_ checks only. You still
have to grant CAP_NET_BIND_SERVICE for binding to ports below PROT_SOCK.
So, this doesn't look like a viable solution for me.

Anyway, thanks for this pointer, I'll look into socket_bind().

Regards, Olaf.
