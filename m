Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbREQO3l>; Thu, 17 May 2001 10:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbREQO3b>; Thu, 17 May 2001 10:29:31 -0400
Received: from comverse-in.com ([38.150.222.2]:5514 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S261877AbREQO3X>; Thu, 17 May 2001 10:29:23 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678ED8@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Blesson Paul'" <blessonpaul@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: ctags
Date: Thu, 17 May 2001 10:28:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use cscope instead, and vim's front-end to it.
(Emacs fans: XEmacs has a similar support, see cscope page on sourceforge).

Much more powerful than plain tags,
because it allows also things like 
"where are all the calls to this function",
but you still can jump about with ^T/^]

At top level of the kernel source tree (/usr/src/linux) do

find . -name '*.[hc]' -print > cscope.files
cscope -b -k -I/usr/src/linux/include

In the .vimrc used for kernel editing, do:
cscope add /usr/src/linux/cscope.out /usr/src/linux
set cstag

And do :help cscope to see what this thing is about...
Or, for a quick start, just do :cs

See also cscope on sourceforge.

HTH,
	Vassilii

> -----Original Message-----
> From: Blesson Paul [mailto:blessonpaul@usa.net]
> Sent: Thursday, May 17, 2001 4:10 AM
> To: linux-kernel@vger.kernel.org
> Subject: ctags
> 
> 
> 
> find -name '*.[ch]' | ctag -L- &
> echo "set tags-tags">>.vimrc
> 
> Hi
>                    Thanks for the reply. To get the definition of the
> functions above  is enough. Now if there are more than one 
> definition of the
> same function how to get all the definitions
> 
>               by
>                       Blesson Paul
> 
> ____________________________________________________________________
> Get free email and a permanent address at 
> http://www.netaddress.com/?N=1
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
