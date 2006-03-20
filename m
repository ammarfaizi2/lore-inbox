Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWCTVRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWCTVRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWCTVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:17:34 -0500
Received: from terminus.zytor.com ([192.83.249.54]:24472 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030329AbWCTVRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:17:33 -0500
Message-ID: <441F1BD9.9010008@zytor.com>
Date: Mon, 20 Mar 2006 13:17:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, klibc@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Re: Merge strategy for klibc
References: <441F0859.2010703@zytor.com> <20060320202224.GE27946@ftp.linux.org.uk>
In-Reply-To: <20060320202224.GE27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Mon, Mar 20, 2006 at 11:54:01AM -0800, H. Peter Anvin wrote:
> 
>>Okay, as of this point, I think klibc is in quite good shape; my
>>testing so far is showing that it can be used as a drop-in replacement
>>for the kernel root-mounting code.
>>
>>That being said, there is guaranteed to be breakage, for two reasons:
>>
>>a. There are several architectures which don't have klibc ports yet.
>>   Since I don't have access to them, I can't really do them, either.
>>   It's usually a matter of an afternoon or less to port klibc to a
>>   new architecture, though, if you have a working development
>>   environment for it.
> 
> Which ones?
> 

This is the status of architectures in klibc, at least as far as I know.

Note that 64-bit architectures which have 32-bit fallback modes (e.g. 
MIPS) can use the 32-bit klibc if applicable.

    alpha:        Working
    arm-thumb:    Untested
    arm:          Working
    arm26:        Not yet ported
    cris:         Working
    h8300:        Not yet ported
    i386:         Working
    ia64:         Working
    m32r:         Untested
    m68k:         Not yet ported
    mips:         Working
    mips64:       Not yet ported
    parisc:       Working
    parisc64:     Not yet ported
    ppc:          Working
    ppc64:        Working
    s390:         Working static, shared untested
    s390x:        Working
    sh:           Untested
    sh64:         Not yet ported
    sparc:        Working
    sparc64:      Untested
    v850:         Not yet ported
    x86-64:       Working
    xtensa:       Not yet ported

	-hpa
