Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131706AbRAEOyv>; Fri, 5 Jan 2001 09:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbRAEOyl>; Fri, 5 Jan 2001 09:54:41 -0500
Received: from hermes.mixx.net ([212.84.196.2]:47115 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131706AbRAEOyd>;
	Fri, 5 Jan 2001 09:54:33 -0500
Message-ID: <3A55DF78.F92AC570@innominate.de>
Date: Fri, 05 Jan 2001 15:51:36 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: More better in mount(2)
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIEPACJAA.law@sgi.com>  	<10101051142.ZM11680@wobbly.melbourne.sgi.com>  	<01010503292006.00477@gimli> <10101051340.ZM14895@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> On Jan 5,  3:26am, Daniel Phillips wrote:
> > ...
> > This filesystem mount option parsing code is completely ad hoc, and uses
> > strtok which is horribly horribly broken.  (Do man strtok and read the
> > 'Bugs' section.)
> >
> > It would be worth thinking about how to do this better.
> 
> hmm ... can't claim I wrote this code, just looked at it.
> are you saying the kernel strtok is horribly broken or just
> the way its being used here?  (and why?)

>From the man page:

BUGS        Never use this function. If you do, note that:  
            This function modifies its first argument.  
            The identity of the delimiting character is lost.  
            This functions cannot be used on constant  strings.  
            The  strtok  () function uses a static buffer while
            parsing, so it's not thread safe. Use  strtok_r  ()
            if this matters to
you.                                                                                                        
--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
