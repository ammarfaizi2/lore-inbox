Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287237AbSAGV7M>; Mon, 7 Jan 2002 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287244AbSAGV7D>; Mon, 7 Jan 2002 16:59:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59148 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287234AbSAGV6w>;
	Mon, 7 Jan 2002 16:58:52 -0500
Message-ID: <3C3A1A18.6B87CDE9@mandrakesoft.com>
Date: Mon, 07 Jan 2002 16:58:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NcLw-0001R9-00@starship.berlin> <3C3A13F8.33BABD62@mandrakesoft.com> <20020107214925.GH1026@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> 
> Em Mon, Jan 07, 2002 at 04:32:40PM -0500, Jeff Garzik escreveu:
> > I am very much interested in a better solution...  I could not figure
> > out how to get a private pointer from a struct inode*, without using a
> > nasty OFFSET_OF macro or a pointer to self as I implemented.
> 
> Why nasty, don't you like the list_head macros? 8) BTW, thats how Linus
> suggested it to be done in private conversation. Look at list_entry.

Yep, sorry Linus :)  I just much prefer inserting the back-ref at object
creation time to pointer arithmetic...  that way there is no type
information lost, and it gives the compiler a better opportunity to see
the relationship between the two structs.

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
