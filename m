Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281311AbRKMAfU>; Mon, 12 Nov 2001 19:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281304AbRKMAfB>; Mon, 12 Nov 2001 19:35:01 -0500
Received: from AGrenoble-101-1-4-53.abo.wanadoo.fr ([217.128.202.53]:19840
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281298AbRKMAe4> convert rfc822-to-8bit; Mon, 12 Nov 2001 19:34:56 -0500
Message-ID: <3BF06B44.1040709@wanadoo.fr>
Date: Tue, 13 Nov 2001 01:37:24 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Sean Elble <S_Elble@yahoo.com>
Cc: joeja@mindspring.com, John Alvord <jalvo@mbay.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Testing Kernel Releases Before Being Released (Was Re: Re: loop back broken in 2.2.14)
In-Reply-To: <Springmail.105.1005596822.0.40719200@www.springmail.com> <00c701c16bd2$e4b11800$0a00a8c0@intranet.mp3s.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess the way I'd do it would be to actually freeze [in which I mean 
no more 'testing' patch are applied] a pre something, say 2.4.XpreY for 
example, see if there are any obvious bugs in it (like the loopback in 
2.4.14), correct them, test again, and if it's okay,
release 2.4.X.

Of course, I've never done much kernel work except testing, so I'm not 
exactly the one who should talk about it.

Still, I think that from the user point of view (and there was a post in 
LKML yesterday, about Linux being used by UN*X experienced sysadmins 
only... or going mainstream instead) the releases should be tested a bit 
more thoroughly and actually *frozen* for some time (a day or two should 
suffice I guess) before being labelled 2.4.X.

Just the two cents from a newbie - I hope/mean to offense noone with that

François Cami



Sean Elble wrote:

> Something definitely should be done to help "stabilize" the tree; it's not
> really a big deal for most of us if something is broken, as you know there
> will be a fix posted very soon after the release, _but_ bugs like these
> don't exactly make Linux "look good" to the rest of the UNIX community. A
> FreeBSD advocate might say "well, FreeBSD never does _that_". My suggestion
> to help fix the problem would be to do what SGI does; have two seperate
> trees that strive to stay as close to each other as possible, but one
> becomes part of the "maintaince stream", where only bug fixes and the such
> are added, and a "features stream", where actual new features are added in.
> Take a look at some of the IRIX web pages at http://www.sgi.com/ for a
> better idea of how that works, but believe me, it works. This would be in
> addition to some sort of testing suite that each official kernel must pass
> before it is released. With the growing number of (important/big) Linux
> users, we must make sure each kernel is rock-solid before being released.
> This is definitely more of a political topic than a technical one, but it
> has to be addressed nonetheless.
> 
> -----------------------------------------------
> Sean P. Elble
> Editor, Writer, Co-Webmaster
> ReactiveLinux.com (Formerly MaximumLinux.org)
> http://www.reactivelinux.com/
> elbles@reactivelinux.com
> -----------------------------------------------
> 
> ----- Original Message -----
> From: <joeja@mindspring.com>
> To: "John Alvord" <jalvo@mbay.net>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Monday, November 12, 2001 3:27 PM
> Subject: Re: Re: loop back broken in 2.2.14
> 
> 
> 
>>I thought that the -pre would be the developer kernels, and that an actual
>>
> release (2.4.14) would have been somewhat tested.  I fully understand that a
> 'runtime' bug in the vm or some other system could arrise and that is one
> thing. I also understand when a 'less used' driver like NTFS or VFAT breaks,
> but to see bugs in the loop device in a 'stabilizing' kernel is something
> that I thought I'd never see.
> 
>>Hmm anyone working on a regression testing tool for the kernel compilation
>>
> options??
> 
>>Also new features DO go into stable trees, there are many times when 2.3.x
>>
> was open that stuff was backported to 2.2.x.  I also heard that ext3 might
> end up in 2.4.15, which I'd love to see happen (that and lm_sensors)
> 
>>I DO think that there needs to be a better way of handling some of these
>>
> small bugs.  Like maybe where the kernel is posted (in my case obtaining
> from ftp.kernel.org) there should be a readme.first.2.4.14 for every version
> of the kernel and in there things like this could be stated.  Simple one
> line in loop.c commment out the two lines or remove the two lines with
> deactivate_page.
> 
>>I don't mind 'testing', but how can you test what wont compile or what
>>
> compiles but does not run?
> 
>>Joe
>>John Alvord <jalvo@mbay.net> wrote:
>>
>>>In developer-speak, stable == stablizing, which means that fixes go in
>>>
>>but no new features. That can include monstrous fixes like the VM
>>cleanup.
>>
>>When you are running developer kernels, you are on the kernel test
>>team whether you know it or not, whether you think thats OK or hate
>>it.
>>
>>For "stable" kernels, wait for the distributors like red hat/suse/etc.
>>There is no way around serious testing which they perform.
>>
>>john
>>
>>
>>On Mon, 12 Nov 2001 12:40:43 -0500, joeja@mindspring.com wrote:
>>
>>
>>>Okay, I can delete out those two lines to get loop working.
>>>
>>>Is 2.4.x really a stable tree?  Or should I wait for 2.4.25 before I
>>>
> consider it really stable?
> 
>>>>>FranÃ§ois Cami wrote:
>>>>>
>>>>>
>>>>>>yes, see 2.4.15pre1
>>>>>>warning, the iptables code in 2.4.15pre1 and pre2 seems broken.
>>>>>>
>>>>>and further it is likely that pre3 fixes iptables code :)
>>>>>(it looks like the patch got reverted)
>>>>>
>>>>Actually it doesn't seem to be reverted,
>>>>just reworked -
>>>>
>>>hmm, spoke too soon -
>>>
>>>looks like they were reverted after all...
>>>
>>>cu
>>>
>>>jjs
>>>
>>>
>>>-


