Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRC3GMw>; Fri, 30 Mar 2001 01:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbRC3GMn>; Fri, 30 Mar 2001 01:12:43 -0500
Received: from web5203.mail.yahoo.com ([216.115.106.97]:18438 "HELO
	web5203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130733AbRC3GMb>; Fri, 30 Mar 2001 01:12:31 -0500
Message-ID: <20010330061149.6234.qmail@web5203.mail.yahoo.com>
Date: Thu, 29 Mar 2001 22:11:49 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: Original destination of transparent proxied connections?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I found it.

While researching replacing the 2.2 kernel with 2.4 to
get my proxy-oid to work, I stumbled accross the
following section in the unofficial NAT-HOWTO (which
is not on linuxdoc's website as far as I can tell). 
At this address:

http://netfilter.kernelnotes.org/unreliable-guides/NAT-HOWTO/NAT-HOWTO.linuxdoc-4.html

Under section four ("quick translation from 2.0 and
2.2 kernels"), under the heading "Hackers may also
notice:", item two in the list:

>The (undocumented) `getsockname' hack, which
>transparent proxy programs could use to find out the
>real destinations of connections no longer works. 

Ah!  A clue!  But no idea how to make it work under
2.4, and no mention of what replaces it!  (I read the
rest of the howto carefully.  Never mentioned this
topic again.)  But there IS a way to get it to work
under 2.2, if I can learn an undocumented (but
functional) hack.

So I jump to the contents page to see who the HOWTO
maintainer is to ask rather pointed questions.  His
email address isn't listed, but I do I find out that
the netfilter mailing list is at
netfilter@lists.samba.org.  http://list.samba.org
turns out to have a page of hosted lists, with a link
that eventually leads to an archive, which is not
easily searchable except by date.  Fun.

This brings us to google, which can find anything if
you just know what to ask for.  I search for
"lists.samba.org netfilter getsockname".  The first
hit is just that silly howto again, but the second
hit:

http://lists.samba.org/pipermail/netfilter/2000-September/005317.html

An explanation, complete with example code.  From
september of last year.

And there was much rejoicing.

If I were to perhaps send linuxdoc.org a check or
something, might a day come to pass when learning to
do seemingly obvious things under linux does NOT
require fairly good forensic investigation skills?  I
ask merely for information.

I need to get more caffiene now.  I'm going to be up
REALLY late coding. :)

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/?.refer=text
