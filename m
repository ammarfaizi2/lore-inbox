Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWHWEf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWHWEf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 00:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWHWEf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 00:35:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:44628 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751330AbWHWEf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 00:35:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LXF5kdzQsaV2Eu1C6BKA+TbGmeAGImrqFKpaDox+2+P2fU6ygUlrrEMdKSApG6Wbeum0GIKMNtlbO8Xn32vuP2ah7NBmwSl1Jn3PJ/SakwUw2lkjrTQo7IyVbP9AS0OWiFOaPjRoIETlDe+UL8LTKUBKMPZugVm/hWcKa5VGk2Y=
Message-ID: <787b0d920608222135g4751ad8v567bf8098e0fb170@mail.gmail.com>
Date: Wed, 23 Aug 2006 00:35:26 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: drepper@redhat.com, nmiell@comcast.net, davem@davemloft.net,
       jmorris@namei.org, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper writes:

> I so far also haven't taken the time to look exactly at the
> interface. I plan to do it asap since this is IMO our big chance
> to get it right. I want to have a unifying interface which can
> handle all the different events we need and which come up today
> and tomorrow.  We have to be able to handle not only file
> descriptors and AIO but also timers, signals, message queues
> (OK, they are file descriptors but let's make it official),
> futexes.  I'm probably missing the one or the other thing now.

Yeah, you're missing one. I must warn you, it's tasteless.
You forgot ptrace events. (everybody now: EEEEEEEW!)

The wait-related functions in general are interesting.
People like to use a general event mechanism to deal with
threads exiting. Seriously, it would really help with
porting code from that other OS.

How about SysV semaphores?
