Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBTXqM>; Tue, 20 Feb 2001 18:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130300AbRBTXqD>; Tue, 20 Feb 2001 18:46:03 -0500
Received: from code.and.org ([63.113.167.33]:972 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S129107AbRBTXpr>;
	Tue, 20 Feb 2001 18:45:47 -0500
To: hps@tanstaafl.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <nn4rxz7lqy.fsf@code.and.org>
	<96c39t$o1g$1@forge.intermeta.de>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 20 Feb 2001 18:45:21 -0500
In-Reply-To: "Henning P. Schmiedehausen"'s message of "Tue, 13 Feb 2001 19:52:29 +0000 (UTC)"
Message-ID: <nn1yssudf2.fsf@code.and.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" <hps@tanstaafl.de> writes:

> james@and.org (James Antill) writes:
> 
> >"Henning P. Schmiedehausen" <hps@tanstaafl.de> writes:
> 
> >> % telnet mail.bar.org smtp
> >> 220 mail.foo.org ESMTP ready
> >>     ^^^^^^^^^^^^
> >> 
> >> This kills loop detection. Yes, it is done this way =%-) and it breaks
> >> if done wrong.
> 
> > This is humour, yeh ?
> 
> No.

 This was a comment on the "loop detection" claim.

[snip ... domain example]

> No. This is a misconfiguration. Yes, RFC821 is a bit rusty but as far
> as I know, nothing has superseded it yet. And Section 3.7 states
> clearly:
> 
>       Whenever domain names are used in SMTP only the official names are
>       used, the use of nicknames or aliases is not allowed.

 _In_ SMTP, that doesn't say anything about MX records to me and even
if it does it's very old and needs to change.

> And the 220 Message is defined as
> 
> 220 <domain>

 So... you should have the reverse for the ip address after the
220. Which most people do (but not all, mainly due to there not being
enough ips).

[snip CNAME lesson]

 The question was, why can't you use CNAMEs. You said 'because of loop
detection'. I said 'But that doesn't work anyway, because you can have
to names pointing at one machine without a CNAME record ... and that
needs to, and currently does, work'.

> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

 Let me put it this way...

tanstaafl.de.		IN MX	50 mail.hometree.net.
tanstaafl.de.		IN MX	10 mail.intermeta.de.
intermeta.de.		IN MX	50 mail.hometree.net.
intermeta.de.		IN MX	10 mail.intermeta.de.

mail.hometree.net.	IN A	194.231.17.49
mail.intermeta.de.	IN A	212.34.181.3

49.17.231.194.in-addr.arpa.  IN PTR  limes.hometree.net.
3.181.34.212.in-addr.arpa.  IN PTR  babsi.intermeta.de.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
