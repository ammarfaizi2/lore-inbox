Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289091AbSAIXqP>; Wed, 9 Jan 2002 18:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289092AbSAIXqG>; Wed, 9 Jan 2002 18:46:06 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:55807 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S289091AbSAIXp7>; Wed, 9 Jan 2002 18:45:59 -0500
Message-ID: <3C3CD691.354986F3@oracle.com>
Date: Thu, 10 Jan 2002 00:47:29 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: ext3 umount oops in 2.5.2-pre10
In-Reply-To: <1010601760.29727.138.camel@jen.americas.sgi.com> <3C3CC176.83F49A74@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> 
> Steve Lord wrote:
> >
> > It looks like ext3 does not work if you do not use an external
> > journal device - the journal_bdev field is not initialized and
> > ext3_put_super goes belly up:
> 
> I have seen the umount oops -but- not 100% of the time. No time
>  to copy the oops text since my laptop powers off, and as the
>  issue occurred two times out of five or six, I haven't yet had
>  a very strong need to hunt this further, confident someone more
>  clueful than me (possibly the vast majority of l-k :) would do
>  very soon. It looks like it happened. Heh. As always.
> 
> > At the very least it needs this:
> 
> [snipped patch]
> 
> OK, going to the usual patch/build/reboot/test sequence now.

Of course the last 252p10 shutdown saw the oops, leaving me
 with the doubt that I didn't attend all the shutdowns :/

And of course the patch makes the oops go away (four reboots
 in a row without any problem). Thanks !

Ciao,

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
