Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSIBXv3>; Mon, 2 Sep 2002 19:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318607AbSIBXv2>; Mon, 2 Sep 2002 19:51:28 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:11217 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S318602AbSIBXv1>; Mon, 2 Sep 2002 19:51:27 -0400
Date: Tue, 3 Sep 2002 00:55:53 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: linux-kernel@vger.kernel.org
Subject: [ot] Re: Stupid anti-spam testings...
In-Reply-To: <20020902233230.GC5834@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0209030044210.12780-100000@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (17m12x-0003VL-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:32 +0300 Matti Aarnio wrote:

>On Mon, Sep 02, 2002 at 04:28:37PM -0600, Andreas Dilger wrote:
>...
>> Do you know if this is one of the default checks from spamassassin?
>
>  No idea.  I have seen these coming from Exim 4.10, Exim-something,
>  some sendmail milter (whatever that is), etc..
>
>  Apparently the idea (which I have thought of long ago, and rejected
>  as incomplete) has caught, and has multiple implementations...

I only speak (and even then not officially) for Exim's implementation,
which is "verify = sender/callout" in Exim 4. I will check to see what
caches may or may not apply. (I think Exim might not cache this, in which
case I'll try to get this caching onto the wish list.)

Anyway I think this kind of paranoia is just silly. It's trivial to forge 
a valid sender address, so why bother checking anything other than a 
syntactically valid domain name?

>  - usw-sf-list1.sourceforge.net  use probably their own code
>    usw-sf-fw2.sourceforge.net too...  possibly more systems there..

These may well be Exim.

>  - quetz.demon.co.uk tests from  Exim 4.10
>  - somebody.symons.net tests from Exim 3.35
>
>  Right now something like 5-7 different systems are doing it.
>  Try to imagine when all 3500 targets do it...  BRRRRR...
>  (Sure, VGER can handle it, no problem, but it is that much
>   wasted cycles, and network traffic...)

In Exim's case the network traffic will be minimal:

EHLO host.name
MAIL FROM:<>
RCPT TO:<sender@for.verify>
RSET

..is about as much as you'll get. The wasted cycles will be more 
important.

Sorry for the noise on the list..

