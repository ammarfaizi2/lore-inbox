Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTAaXPu>; Fri, 31 Jan 2003 18:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTAaXPt>; Fri, 31 Jan 2003 18:15:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13582 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263256AbTAaXPs>;
	Fri, 31 Jan 2003 18:15:48 -0500
Message-ID: <3E3B0557.3070400@pobox.com>
Date: Fri, 31 Jan 2003 18:23:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <20030131222257.GA11011@mars.ravnborg.org>
In-Reply-To: <20030131222257.GA11011@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sigh, I did not wish to spark a religious debate, though I suppose I 
should have expected it... :))

Sam Ravnborg wrote:
> On Fri, Jan 31, 2003 at 10:38:27PM +0100, J.A. Magallon wrote:
> 
>>So in short, kernel people:
>>- do not want perl in the kernel build
> 
> Correct, at least for mainstream architectures.
> The rationale here is that we already put a lot of constraints on what
> tools people need to build a kernel. If we can avoid an extra
> _mandatory_ tool then this will make life easier for a lot of people.

This is a logically correct argument, but also one that ignores basic 
numbers.

The fact of the matter is, the area of build tools matters most to 
people who cross-compile their kernels, because every tool is generally 
hand-built rather than automatically installed on their Linux system. 
For this audience, as well as the typical non-cross-compiling kernel 
developer, Perl is on their system.

However, that fact is less significant than the more basic and core 
argument:

klibc uses perl for text munging.  i.e. one of Perl's acknowledged 
strengths.  This is not a case of choosing a favorite script language, 
but instead a case of choosing "the right tool for the job."  Regardless 
of whether you think Perl is line noise :) or not, from a technical 
basis Perl is clearly superior to sed+awk in this case.

Therefore, any rewrite of _this_ _particular_ script in C or shell 
script would be willfully choosing a sub-optimal implementation language 
for this task.  If you take into account the fact that the overwhelming 
majority of the target audience does indeed have Perl on their system, 
then that only serves to make it more clear that any such perl-to-C 
rewrite would not be on any technical nor practical basis at all.

Adding some final thoughts, perl is already used in nooks and crannies 
in the build system.  Instead of being motivated to stomp those out, 
please [respectfully!] consider that the Perl scripts might be there 
because an evaluation of the best tool for the job took place. 
script_asm.pl in drivers/scsi is a favorite example here.

Thanks for raising this subject!  I wanted to give your answer some 
consideration, because it is worth mentioning, and discussing.

	Jeff



