Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUAYPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 10:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbUAYPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 10:06:28 -0500
Received: from mail.aei.ca ([206.123.6.14]:12499 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S264286AbUAYPG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 10:06:26 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: i/o wait eating all of CPU on 2.6.1
Date: Sun, 25 Jan 2004 10:06:05 -0500
User-Agent: KMail/1.5.93
Cc: Jaakko Helminen <haukkari@ihme.org>
References: <20040125143042.GA20274@ihme.org>
In-Reply-To: <20040125143042.GA20274@ihme.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401251006.06355.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of things.  IO wait does not 'eat cpu'.  Its a wait state, recorded
when the box has nothing to do and IO is pending.  That being said I remember
reading here about nfs bugs in 2.6.1 that slow it down.  A search should
find some patches for you to try.

Ed

On January 25, 2004 09:30 am, Jaakko Helminen wrote:
> I have two servers, both of which have more than 300 gigabytes of hard
> drive space and those files are made available to the network with samba,
> nfs and http and it worked fine with 2.6.0 but when I upgraded to 2.6.1 I
> noticed that everything was VERY slow, from a machine that is connected to
> the other server with a 100M link, 57kB/s tops. i/o wait eats up all of the
> cpu. On the other hand, Apache (and everything else) works very fast when I
> only send /dev/zero to a client, since that doesn't need disk operations.
>
> I don't notice anything suspicious in dmesg but since this happens on two
> machines and has only happened when upgraded to 2.6.1, it's most likely
> because of 2.6.1. I'm downgrading to 2.6.0 (with mremap-patch) today if I
> don't figure out what is wrong. Any ideas?
>
> And since I'm not subscribed to Linux Kernel Mailing List, please forward
> any replies to me.
>
>
> -Jaakko Helminen
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
