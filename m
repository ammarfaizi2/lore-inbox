Return-Path: <linux-kernel-owner+w=401wt.eu-S933243AbXAADjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243AbXAADjl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 22:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933246AbXAADjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 22:39:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:58175 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933243AbXAADjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 22:39:40 -0500
In-Reply-To: <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
References: <459714A6.4000406@firmworks.com> <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ba169b0e106ecbaebf480bf218fdf91f@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "OLPC Developer's List" <devel@laptop.org>,
       Mitch Bradley <wmb@firmworks.com>, Jim Gettys <jg@laptop.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Mon, 1 Jan 2007 04:40:00 +0100
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +A regular file in ofwfs contains the exact byte sequence that
>> +comprises the OFW property value.  Properties are not reformatted
>> +into text form, so numeric property values appear as binary
>> +integers.  While this is inconvenient for viewing, it is generally
>> +easier for programs that read property values, and it means that
>> +Open Firmware documentation about property values applies
>> +directly, without having to separately document an ASCII
>> +transformation (which would have to separately specified for
>> +different kinds of properties).
>
> I appreciate the ASCII formatting that openpromfs currently does.

The text representation (in openpromfs) is *useless*, since it cannot
be transformed back into the binary representation.

Most tools have an easier time using the raw binary version too.
If a user wants to see text, they can use an "lsdevtree" program.

> Perhaps, should OFWFS be used, it could offer both?

Such transformations don't belong in the kernel but in userland.

>> +The recommended mount point for ofwfs is /ofw.  (TBD: Should it be
>> +mounted somewhere under /sys instead?)
>
> Somewhere in /sys/firmware perhaps.

While I hate deep paths, /sys/firmware/device-tree does sound good.


Segher

