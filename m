Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310469AbSCPR1D>; Sat, 16 Mar 2002 12:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310460AbSCPR0q>; Sat, 16 Mar 2002 12:26:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310459AbSCPR0Z>;
	Sat, 16 Mar 2002 12:26:25 -0500
Message-ID: <3C938027.4040805@mandrakesoft.com>
Date: Sat, 16 Mar 2002 12:25:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>On Sat, Mar 16, 2002 at 12:06:10PM -0500, Jeff Garzik wrote:
>
>>This was just an example of a real world example that actually happened, 
>>where BK sucked ass :)
>>
>
>Think file systems.  Think 2 file systems.  Think creating duplicate inodes
>in the same place.  Now those 2 file systems are merged into a third, the
>duplicates removed.  The original 2 still both exist and are both being
>updated.  
>
Like I said, I know why BK is going what it is doing.  That doesn't 
change the fact that peoples options are very poor in this case.

>>Marcelo's BK tree did not exist when I created my marcelo-2.4 tree. 
>> marcelo-2.4 repo existed for a while and people started using it.  Once 
>>Marcelo appeared with his "official" BK tree, people naturally want to 
>>migrate.  There were two migration paths: (1) export everything to GNU 
>>patches, or (2) click the mouse 300 times.
>>
>
>There is a 3rd:  factor out the duplicates and and export/import only the
>ones that Marcelo didn't have, then dump your tree and use his.
>

That's what I meant by option #1...  you yelled at me, rightly, when I 
first tried to send BK patches to Linus, because I used 'bk export'.  If 
you have to leave the BK system entirely for certain cases of merging, 
that's really a failing of the system.  So, I chastise you back for even 
suggesting 'export' :)

Basically you need out of order changes to do it right...

I think a fair question would be, is this scenario going to occur often? 
 I don't know.  But I'll bet you -will- see it come up again in kernel 
development.  Why?  We are exercising the distributed nature of the 
BitKeeper system.  The system currently punishes Joe in Alaska and 
Mikhail in Russia if they independently apply the same GNU patch, and 
then later on wind up attempting to converge trees.

Do you see what I'm getting at?  In a widely distributed SCM system for 
an open source project, chances are -good- that some random two or more 
people will independently apply the same patch.

    Jeff



