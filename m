Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315831AbSEMFIu>; Mon, 13 May 2002 01:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315835AbSEMFIt>; Mon, 13 May 2002 01:08:49 -0400
Received: from [216.187.66.157] ([216.187.66.157]:48402 "EHLO
	prime.killermeat.com") by vger.kernel.org with ESMTP
	id <S315831AbSEMFIt>; Mon, 13 May 2002 01:08:49 -0400
Message-ID: <1021266220.3cdf492c48333@mail.fortyoz.org>
Date: Sun, 12 May 2002 22:03:40 -0700
From: David Raufeisen <david@fortyoz.org>
To: linux-kernel@vger.kernel.org
Subject: Uhhuh. NMI received for unknown reason 20. ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm setting up a new server, it has a new Intel ServerWorks board with dual 
1.266ghz P3 CPU's and 2gb ram.

I'm running into a few problems with it, crashing and strange error messages, 
if anyone is familiar with these problems i'd appreciate a heads up on how to 
handle them.

I currently have it running 2.4.19pre8, it would crash quite easily with 2.4.18 
with redhat's kernel patches from their rawhide distribution while compiling 
multiple kernels simultaneously. I will try to get a cable and capture the oops 
with serial console.

Here is dmesg output..

http://fortyoz.org/files/misc/svwks-dmesg.txt

Something that worries me:

Uhhuh. NMI received for unknown reason 20.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?

In the bios it had generate NMI on SERR and generate NMI on PERR, i disabled 
them but still get this message when doing intensive things (compiling kernels).

Does this message mean bad things are certain to come or can it be harmless?

I'm going to leave it compiling kernels overnight and see if it's dead in the 
morning.

# cat /proc/interrupts
           CPU0       CPU1
  0:     115002     104624    IO-APIC-edge  timer
  1:         81         94    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 14:          4          0    IO-APIC-edge  ide0
 18:     296766     296544   IO-APIC-level  eth0
 21:      20983      20895   IO-APIC-level  ide2, ide3
NMI:          1          0
LOC:     219526     219524
ERR:          0
MIS:          0


Also with regards to the promise controller, it should be running at ATA100 but 
is only reported at ATA33, it has the proper cables and the drives and 
controller card are certainly capable, any idea?

Thanks for any help.

-- 
David Raufeisen <david@fortyoz.org>
