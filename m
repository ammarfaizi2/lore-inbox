Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBBVPz>; Fri, 2 Feb 2001 16:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129964AbRBBVPn>; Fri, 2 Feb 2001 16:15:43 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:7181 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129282AbRBBVPj>; Fri, 2 Feb 2001 16:15:39 -0500
Message-ID: <3A7B1BFA.F7B4EAD@namesys.com>
Date: Fri, 02 Feb 2001 23:43:38 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Chris Mason <mason@suse.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <200102021825.f12IPCu20705@devserv.devel.redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > So, did Linus say no?  If not, let's ask him with a patch.  Quite simply,
> > neither we nor the users should be burdened with this, and the patch removes
> > the burden.
> 
> Since egcs-1.1.2 and gcc 2.95 miscompile the kernel strstr code dont forget
> to stop those being used as well. Oh look you'll need CVS gcc to build the
> kernel... ah but wait that misbuilds DAC960.c...
> 
> Oh look nothing compiles the kernel.
> 
> Congratulations 8)
> 
> Alan


Users cannot use gcc 2.96 as shipped in RedHat 7.0 if they want to use
reiserfs.  It is that simple.  How can you even consider defending allowing the
use of it without requiring a positive affirmation by the user that they don't
know what they are doing and want to do it anyway?:-)  I could understand
arguing that you don't want to be bothered with protecting the users because you
don't have the time, but if somebody else finds the time to write the patch....

I would indeed encourage Linus to accept patches to test for known bad compilers
at make time.  It is less work for us all to prevent users from having bugs than
to respond to their having them.  I look forward to gcc 3.00, and I encourage
the compiler guys to get over being (understandably) irked that somebody else
released their code prematurely, and to increment the version number to 2.97 so
that users can more easily avoid the baddie.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
