Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTAIFOy>; Thu, 9 Jan 2003 00:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTAIFOy>; Thu, 9 Jan 2003 00:14:54 -0500
Received: from holomorphy.com ([66.224.33.161]:34190 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261615AbTAIFOx>;
	Thu, 9 Jan 2003 00:14:53 -0500
Date: Wed, 8 Jan 2003 21:23:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
Message-ID: <20030109052327.GC8544@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
	levon@movementarian.org, linux-kernel@vger.kernel.org
References: <20030108.150303.130044451.davem@redhat.com> <Pine.LNX.4.44.0301081601300.1096-100000@penguin.transmeta.com> <20030108.160352.78071329.davem@redhat.com> <20030109040025.GA11596@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030109040025.GA11596@nevyn.them.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 04:03:52PM -0800, David S. Miller wrote:
>> A funny way to initialize this could be by reading System.map
>> and seeing how many significant hexidecimal digits are used
>> to list the kernel symbol addresses :-)

On Wed, Jan 08, 2003 at 11:00:25PM -0500, Daniel Jacobowitz wrote:
> Don't try it, the perversity of MIPS will break you :)
> Just to clarify something that I saw getting lost in this discussion:
> Oprofile doesn't need to become built as a 64-bit binary, just
> configured to accept 64-bit kernels.  So this doesn't rule out using a
> 32-bit oprofile (i.e. not needing a 64-bit libc) on a 64-bit kernel. 
> It just means that we need to specify it somehow.
> John, speaking of MIPS perversity: MIPS64 kernels can come in ELF32
> files.  So you may just want to make this a configure-time option.

pkirchner has informed me /proc/kcore returns the correct information
in this case on MIPS, and I've also received x86-32/64 confirmation.

64-bit in 32-bit ELF: <pkirchner:#mipslinux>  it does say  abi=674 mips1 not 32bitmode not fp32
DecStation 5000/200: /proc/kcore:     file format elf32-tradlittlemips


Bill
