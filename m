Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTEHJcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTEHJcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:32:10 -0400
Received: from mailsrv1-tu0.sanger.ac.uk ([193.62.206.128]:30727 "EHLO
	mailsrv1.sanger.ac.uk") by vger.kernel.org with ESMTP
	id S261239AbTEHJcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:32:08 -0400
Message-ID: <3EBA26FC.5030305@thekelleys.org.uk>
Date: Thu, 08 May 2003 10:44:28 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Filip Van Raemdonck <mechanix@debian.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J. Bruce Fields" <bfields@fieldses.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: Binary firmware in the kernel - licensing issues.
References: <3EB79ECE.4010709@thekelleys.org.uk> <20030506121954.GO24892@mea-ext.zmailer.org> <20030506151644.GA19898@fieldses.org> <3EB7D7D9.2050603@thekelleys.org.uk> <1052234481.1202.20.camel@dhcp22.swansea.linux.org.uk> <3EB8AD41.5010605@thekelleys.org.uk> <20030507090700.GD25251@debian> <3EB8D7D9.7070304@thekelleys.org.uk> <20030508080116.GD15296@debian>
In-Reply-To: <20030508080116.GD15296@debian>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Filip Van Raemdonck wrote:
> On Wed, May 07, 2003 at 10:54:33AM +0100, Simon Kelley wrote:
> 
>>Now Linus could say "I consider that the kernel copyright holders 
>>did/didn't give permission to combine  their work with firmware blobs" 
>>and I contend that practically all the copyright holders would go along
>>with that judgement, just as they went along with Linus's judgement
>>about linking binary-only modules with their work.
> 
> 
> It's been pointed out repeatedly that there are a few which disagree with
> this; they just did not feel compelled (yet?) into action over it.
> 
> But there is an important difference in binary modules vs binary
> firmware blobs.
> 
> In the modules case, it's the binary modules provider which exposes
> himself to legal issues.
> In the firmware case, you are exposing the kernel itself to IP liability
> issues. Do you really want that? (Think SCO)
> 

For the avoidance of doubt and in the particular case of the Atmel
drivers which started this discussion, I have absolutely _no_ intention
of exposing the kernel to outside IP liability issues. I have already
contacted Atmel and I am talking to them about changing their licence to
explicily allow redistribution as part of Linux; if
I do not get a satifactory outcome from the those discussions I will
not include firmware with the driver.

I don't however anticipate getting Atmel to release the _source_ to
their firmware so this still leaves the issue of the source-distribution
clause in the GPL and if it applies in this case. The consequences of
making a wrong call on that are to violate the GPL license conditions of
each contribution to the kernel and therefore the copyright of each
copyright holder on a portion of the Linux kernel.

Briefly, the arguments that binary firmware which is copied into the
hardware by the kernel is OK are these.

1) The GPL is unclear on this point.
2) The firmware is not linked with the kernel code and not executed
    by the same processor as the kernel.
3) Not allowing binary firmware leads to technical decisions which would
    not be made in the absence of prohibition.
4) The same hardware and firmware is unambiguously OK if the firmware
    is held in flash rather than initialised by the host.
5) There are current examples in the kernel of drivers with source-free
    binary firmware blobs going back at least to version 1.3. This means
    that someone might have considered this before and OKed it. It also
    means that anyone who added code to the kernel since 1.3 had
    evidence that for Linux the interpration of this GPL grey area
    was to allow binary firmware. It is difficult to a contributor to
    turn around now and claim copyright infrigement by distributing their
    work with binary firmware when the kernel already had binary firmware
    in it when their contribution was first made.
6) AFAIK nobody has claimed that the existing firmware blobs in Linux
    violate their copyright on GPL-licensed kernel contributions and
    fairly certainly nobody has pressed this in law. (Since if they
    had it would be well-known.)


The arguments against allowing binary firmware are these.

1) The GPL is unclear on this point.
2) The intention of the GPL is to allow redistribution only
    with source.
3) Some contributors to the kernel might want their work distributed
    only with all source, including firmware source. These people
    would contend that their copyright had been violated and would
    feel aggrieved or sue for lots of money.


Anybody  want to write a better summary?


Simon.






