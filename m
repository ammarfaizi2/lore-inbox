Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRKLU13>; Mon, 12 Nov 2001 15:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280974AbRKLU1J>; Mon, 12 Nov 2001 15:27:09 -0500
Received: from hall.mail.mindspring.net ([207.69.200.60]:8493 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S280971AbRKLU1D>; Mon, 12 Nov 2001 15:27:03 -0500
From: joeja@mindspring.com
Date: Mon, 12 Nov 2001 15:27:02 -0500
To: John Alvord <jalvo@mbay.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: loop back broken in 2.2.14
Message-ID: <Springmail.105.1005596822.0.40719200@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought that the -pre would be the developer kernels, and that an actual release (2.4.14) would have been somewhat tested.  I fully understand that a 'runtime' bug in the vm or some other system could arrise and that is one thing. I also understand when a 'less used' driver like NTFS or VFAT breaks, but to see bugs in the loop device in a 'stabilizing' kernel is something that I thought I'd never see.

Hmm anyone working on a regression testing tool for the kernel compilation options??

Also new features DO go into stable trees, there are many times when 2.3.x was open that stuff was backported to 2.2.x.  I also heard that ext3 might end up in 2.4.15, which I'd love to see happen (that and lm_sensors)

I DO think that there needs to be a better way of handling some of these small bugs.  Like maybe where the kernel is posted (in my case obtaining from ftp.kernel.org) there should be a readme.first.2.4.14 for every version of the kernel and in there things like this could be stated.  Simple one line in loop.c commment out the two lines or remove the two lines with deactivate_page.  

I don't mind 'testing', but how can you test what wont compile or what compiles but does not run?

Joe
John Alvord <jalvo@mbay.net> wrote:
> In developer-speak, stable == stablizing, which means that fixes go in
but no new features. That can include monstrous fixes like the VM
cleanup.

When you are running developer kernels, you are on the kernel test
team whether you know it or not, whether you think thats OK or hate
it.

For "stable" kernels, wait for the distributors like red hat/suse/etc.
There is no way around serious testing which they perform.

john


On Mon, 12 Nov 2001 12:40:43 -0500, joeja@mindspring.com wrote:

>Okay, I can delete out those two lines to get loop working.
>
>Is 2.4.x really a stable tree?  Or should I wait for 2.4.25 before I consider it really stable?
>
>> > François Cami wrote:
>> >
>> > > yes, see 2.4.15pre1
>> > > warning, the iptables code in 2.4.15pre1 and pre2 seems broken.
>> >
>> > and further it is likely that pre3 fixes iptables code :)
>> > (it looks like the patch got reverted)
>>
>> Actually it doesn't seem to be reverted,
>> just reworked -
>
>hmm, spoke too soon -
>
>looks like they were reverted after all...
>
>cu
>
>jjs
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


