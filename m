Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970790-319>; Tue, 21 Apr 1998 03:14:15 -0400
Received: from smtp.bc.rogers.wave.ca ([24.113.32.20]:37999 "EHLO smtp.bc.rogers.wave.ca" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with ESMTP id <970932-319>; Tue, 21 Apr 1998 03:13:14 -0400
Message-Id: <199804210719.AAA25982@pc-37249.bc.rogers.wave.ca>
To: Kent Brockman <heathclf@skynet.csn.ul.ie>
cc: Eric Schenk <eschenk@rogers.wave.ca>, davem@dm.cobaltmicro.com, linux-kernel@vger.rutgers.edu
Subject: Re: T/TCP: Syn and RST Cookies 
In-reply-to: Your message of "Mon, 13 Apr 1998 12:00:19 BST." <Pine.LNX.3.95.980413115552.26258A-100000@skynet.csn.ul.ie> 
Date: Tue, 21 Apr 1998 00:19:03 -0600
From: "Eric Schenk" <eschenk@pc-37249.bc.rogers.wave.ca>
Sender: owner-linux-kernel@vger.rutgers.edu


Kent Brockman <heathclf@skynet.csn.ul.ie> writes:
>Where could I find out more information about the transactions being
>played twice?

For the record on this one, the researcher in question is
named Mark Smith, and he was, at least a year ago when I last
had contact with him, at MIT working with Nancy Lynch.
His home page, which contains pointers to some of his
work in this area can be found at <http://theory.lcs.mit.edu/~mass/>.

Quick summary for the impatient: T/TCP can get data corruption
and replay conditions under certain types of crash conditions
(A crash condition means a part of the network hickups. It might
be a machine at either end of the link, or it could be a router.)
Even stronger, unless all network transactions obey some
timing assumptions, no protocol that attempts to do what T/TCP does
can work. The open questions as I understand them at this point
are: (1) do the given assumptions get violated in realtity often
enough that we care? (for example, if the probability is signficicantly
lower than the probability of a data corruption that gets past the
checksum screen, then we probably don't), and (2) does T/TCP
as currently specified even work under the assumption that the
timing assumptions in question are obeyed.

Personally, I think T/TCP is a dead issue until these questions are
addressed in a complete and serious manner.

-- 
Eric Schenk                             www: http://www.loonie.net/~eschenk
                          email: eschenk@loonie.net, eschenk@rogers.wave.ca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
