Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRBEXwH>; Mon, 5 Feb 2001 18:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbRBEXvr>; Mon, 5 Feb 2001 18:51:47 -0500
Received: from sfo-gw.covalent.net ([207.44.198.62]:7249 "EHLO hand.dotat.at")
	by vger.kernel.org with ESMTP id <S130012AbRBEXvi>;
	Mon, 5 Feb 2001 18:51:38 -0500
Date: Mon, 5 Feb 2001 23:49:25 +0000
From: Tony Finch <dot@dotat.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dank@alumni.caltech.edu, Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Finch <dot@dotat.at>
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that
Message-ID: <20010205234925.J70673@hand.dotat.at>
In-Reply-To: <3A7F3420.A3B10510@alumni.caltech.edu> <E14Puvx-0004TB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Puvx-0004TB-00@the-village.bc.nu>
Organization: Covalent Technologies, Inc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> How close is TCP_NOPUSH to behaving identically to TCP_CORK now?
>> If it does behave identically, it might be time to standardize
>> the symbolic name for this option, to make apps more portable
>> between the two OS's.  (It'd be nice to also standardize the
>> numeric value, in the interest of making the ABI's more compatible, too.)
>
>That one isnt practical because of the way the implementations handle 
>boolean options. BSD uses bitmask based option setting for the basic
>options and Linus uses switch statements

No, that's only true for some of the socket-level options. For the TCP
options there isn't a direct correspondance between the option number
and the number of the flag in the PCB.

Tony.
-- 
f.a.n.finch    fanf@covalent.net    dot@dotat.at
"Dead! And yet there he stands!"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
