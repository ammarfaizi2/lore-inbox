Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129976AbRBBWBX>; Fri, 2 Feb 2001 17:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRBBWBN>; Fri, 2 Feb 2001 17:01:13 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:61449 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129976AbRBBWBD>; Fri, 2 Feb 2001 17:01:03 -0500
Message-ID: <3A7B269F.A028388C@namesys.com>
Date: Sat, 03 Feb 2001 00:29:03 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Chris Mason <mason@suse.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <200102022133.f12LXO319901@devserv.devel.redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Users cannot use gcc 2.96 as shipped in RedHat 7.0 if they want to use
> > reiserfs.  It is that simple.  How can you even consider defending allowing the
> > use of it without requiring a positive affirmation by the user that they don't
> > know what they are doing and want to do it anyway?:-)  I could understand
> 
> The kernel documentation explicitly says to use egcs-1.1.2 or 2.95 for x86.
> If you want to put in #ifdefs then let me assure you that you will then get
> a million emails that 'reiserfs doesnt build'. I went this way with older
> gcc's in 2.0 and the amount of mail more than doubled by doing the check

I'd rather have them complain it doesn't build than never complain because they
think reiserfs is still a little too new and has bugs.  Also, I just don't think
my convenience matters as much as that of the users.  I don't want to use
#ifdefs, I want it to die explosively and verbosely informatively.  make isn't
the most natural language for that, but I am sure Yura can find a way.

> 
> If people use other compilers then certainly ignore the bug reports. For 2.2
> until recently that was policy with gcc 2.95

We don't (at least not intentionally, surely someone is going to mention one
where we did) ignore bug reports on our mailing list.  Period.

We are capable of telling users, you know, this is user error, if you want
detailed help send me a note that you have put $25 in the mail, and I'll have
someone give you step by step help with it.  If it is easy to narrow the user
error down from the first email I typically just tell them what it is.

> 
> Also remember to check for 2.96 but not 2.96-69 (the errata one) and remember
> to do specific architecture tests as there is no other compiler set available
> for IA64 for example.
> 
> > to respond to their having them.  I look forward to gcc 3.00, and I encourage
> > the compiler guys to get over being (understandably) irked that somebody else
> 
> Gcc 3.0 CVS branch wont build the kernel either right now - DAC960 fails.
> 
> Alan

Please delay shipping the 3.0 CVS branch on RedHat for a while.:-)  Sorry, I
couldn't resist.

Look, everybody lets a piece of software slip out that should not have gone at
some point in their career.  It is just that RedHat is big enough that everyone
is inconvenienced when they do so, and so we need to patch a Makefile to reduce
the annoyance.  No biggie.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
