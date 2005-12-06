Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVLFLOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVLFLOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLFLOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:14:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39088 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750736AbVLFLOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:14:17 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Avuton Olrich <avuton@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic: Machine check exception
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	<1132406652.5238.19.camel@localhost.localdomain>
	<3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
	<1132436886.19692.17.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 06 Dec 2005 04:13:24 -0700
In-Reply-To: <1132436886.19692.17.camel@localhost.localdomain> (Alan Cox's
 message of "Sat, 19 Nov 2005 21:48:06 +0000")
Message-ID: <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sad, 2005-11-19 at 12:54 -0800, Avuton Olrich wrote:
>> Is there a good way to narrow it down? I guess running a badmem
>> program would be good to start with, otherwise ...(?).
>
> A memory test may be worth doing but most machine checks indicate the
> fault is more serious than bad memory.

Although on the Opteron that is usually what it is (as memory
errors can be reported through the machine check interface)

In this case bank 4 is the appropriate bank.  Although the
other bits don't look right for a memory error.  I wonder
if it is that darn iommu fault again.

To decode an Opteron machine_check you can look in
the bios and kernel programmers guide.  (Possibly the
architecture but I think that is too generic) to see
what all of the bits mean.

It is a pain but is faster than poking blindly in
the dark.

Eric
