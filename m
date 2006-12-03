Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936692AbWLCLwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936692AbWLCLwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936694AbWLCLwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:52:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6125 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S936692AbWLCLwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:52:20 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: yhlu <yinghailu@gmail.com>
Cc: "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com>
	<m1irgufl9q.fsf@ebiederm.dsl.xmission.com>
	<2ea3fae10612021247v33cfaa4evbc8ad1d5eaf196ba@mail.gmail.com>
Date: Sun, 03 Dec 2006 04:51:15 -0700
In-Reply-To: <2ea3fae10612021247v33cfaa4evbc8ad1d5eaf196ba@mail.gmail.com>
	(yinghailu@gmail.com's message of "Sat, 2 Dec 2006 12:47:18 -0800")
Message-ID: <m1ejrhfb9o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu <yinghailu@gmail.com> writes:

> On 12/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Please yank the direct out of the filename if you are making something
>> like this out of it.  That was my note I was going direct to hardware
>> which is pretty much assumed if you are in LinuxBIOS.
>
> Yes, I adapted the code to used in LinuxBIOS, including CAR stage code
> and RAM satge code.
>
> I didn't have debug cable plugged yet.

Even if you did it wouldn't work right now.  My initial
version does initialize the ehci properly so it won't
find any usb devices.  I almost have that fixed,
but it looks like for the usb device reset I need
a usable delay function, so I can delay 50ms.  Grr...

> BTW in kernel earlyprintk or prink, you could use
> read_pci_config/write_pci_config before PCI system is loaded.

Yep thanks that seems to be working.  Now I just need
to find an early delay and I can try this mess out!

Eric

