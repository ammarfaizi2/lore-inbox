Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288197AbSAHSNm>; Tue, 8 Jan 2002 13:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288206AbSAHSNd>; Tue, 8 Jan 2002 13:13:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50950 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288197AbSAHSNT>;
	Tue, 8 Jan 2002 13:13:19 -0500
Message-ID: <3C3B36B4.8F7426BF@mandrakesoft.com>
Date: Tue, 08 Jan 2002 13:13:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@transmeta.com, hch@caldera.com, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt abstraction
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
>         ftp://infradead.org/pub/people/dwh/preempt-252p10.diff.bz2

> It also replaces instances of:
> 
>         if (current->need_resched())
>                 schedule();
> 
> With:
> 
>         preempt();


Regardless of the benefit of abstracting access to
current->need_resched, I've always thought something like this was
needed for code cleanliness as well.  Since yield is now in 2.5.2-preXX,
why not add your patch too.  Nice...

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
