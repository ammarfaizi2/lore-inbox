Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbRBBWrB>; Fri, 2 Feb 2001 17:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRBBWqw>; Fri, 2 Feb 2001 17:46:52 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:6929 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129304AbRBBWqq>; Fri, 2 Feb 2001 17:46:46 -0500
Message-ID: <3A7B30FB.C63DBD11@namesys.com>
Date: Sat, 03 Feb 2001 01:13:15 +0300
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
In-Reply-To: <200102022213.f12MDCR27812@devserv.devel.redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > my convenience matters as much as that of the users.  I don't want to use
> > #ifdefs, I want it to die explosively and verbosely informatively.  make isn't
> > the most natural language for that, but I am sure Yura can find a way.
> 
> Run a small shell check and let it fail if the shell stuff errors.
> 
> The fragment you want is
> 
> if [ -e /bin/rpm ]; then
>         X=`rpm -q gcc`
>         if [ "$X" = "gcc-2.96-54" ]; then
>                 echo "*** GCC 2.96-54 will miscompile Reiserfs. Please update your compiler"
>                 echo "See http://www.redhat.com/support/errata/RHBA-2000-132.html"
>                 exit 255
>         fi
> fi
> 
> > Please delay shipping the 3.0 CVS branch on RedHat for a while.:-)  Sorry, I
> > couldn't resist.
> 
> Grin. gcc 3.0 is going to be just as much fun Im sure, but finally should give
> everyone a stable C and more importantly C++ base including the LSB standards.
> 
> Alan

Ok, thanks Alan, we'll use it, Yura, write something resembling or equal to
this, test it, and check it into our CVS branch.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
