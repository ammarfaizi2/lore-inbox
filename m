Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUBXR3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbUBXR3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:29:47 -0500
Received: from a213-22-30-111.netcabo.pt ([213.22.30.111]:8329 "EHLO
	r3pek.homelinux.org") by vger.kernel.org with ESMTP id S262309AbUBXRYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:24:21 -0500
Message-ID: <34679.62.229.71.110.1077643458.squirrel@webmail.r3pek.homelinux.org>
In-Reply-To: <20040224091014.4a605006.rddunlap@osdl.org>
References: <20040224160341.GA11739@in.ibm.com><28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
    <20040224091014.4a605006.rddunlap@osdl.org>
Date: Tue, 24 Feb 2004 17:24:18 -0000 (WET)
Subject: Re: kexec "problem"
From: "Carlos Silva" <r3pek@r3pek.homelinux.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 24 Feb 2004 11:02:21 -0000 (WET) Carlos Silva wrote:
>
> | hi guys,
> |
> | i have just compiled a kernel with the kexec patch. compiled kexec-tools
> | and when i try to load a kernel, it gives me this:
> | # ./do-kexec.sh /boot/bzImage-2.6.2-g
> | kexec_load failed: Invalid argument
> | entry       = 0x91764
> | nr_segments = 2
> | segment[0].buf   = 0x80b3480
> | segment[0].bufsz = 1880
> | segment[0].mem   = 0x90000
> | segment[0].memsz = 1880
> | segment[1].buf   = 0x40001008
> | segment[1].bufsz = 19795a
> | segment[1].mem   = 0x100000
> | segment[1].memsz = 19795a
> |
> | anyone tried to run kexec and actually did it? i'm trying with kernel
> 2.6.3
>
> I haven't updated for 2.6.3 yet, or even tested it...
> but I'll get to it soon.
>
> --
> ~Randy
>


just changed line 13 on kexec.h from:
"long kexec_load(void *entry, unsigned long nr_segments, struct
kexec_segment *segments, unsigned long);"
to:
"long kexec_load(void *entry, unsigned long nr_segments, struct
kexec_segment *segments, unsigned long flags);"

and it gives me this error:
# ./do-kexec.sh /boot/bzImage-2.6.2-g
kexec_load failed: Function not implemented
entry       = 0x91764
nr_segments = 2
segment[0].buf   = 0x80b3480
segment[0].bufsz = 1880
segment[0].mem   = 0x90000
segment[0].memsz = 1880
segment[1].buf   = 0x40001008
segment[1].bufsz = 19795a
segment[1].mem   = 0x100000
segment[1].memsz = 19795a

