Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTDDR73 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTDDR73 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:59:29 -0500
Received: from mail.zmailer.org ([62.240.94.4]:15590 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S263776AbTDDR71 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 12:59:27 -0500
Date: Fri, 4 Apr 2003 21:10:54 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: VGER's filters..
Message-ID: <20030404181054.GT29167@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VGER runs email processing with two layers of filters.
That we need any such thing is due to the sorry state
of email (all manner of spamming all around).

VGER has web-pages where various aspects of the system
are shown, _including_ present filter-rules in Majordomo.
  (  http://vger.kernel.org/  and onwards.. )


We have added also some synchronous filters into VGER's
MTA, so that incoming email gets rejected VERBOSELY to
its sender, when couple common cases are encountered.


  How do these filters work, then ?

Our filters are line-based one-match keyword trigger thingies.
Majordomo 1.x does not have any sort of scoring system.   Nor
have we had much interest in integrating something else, like
SpamAssassin, into our MTA environment to make scorings.


We are treating things like messages of TEXT/PLAIN type with
BASE64 encoded content, or messages with HTML in them  as
obfuscated and potentially spam.   Our rather simple filters
don't decode BASE64 (nor QP, but our MTA decodes that).


I recall that I have myself tried to use Hotmail,  and found
quite easily the setups so that my outgoing email will never
have HTML in them.  -- Current version of HM does not appear
to send HTML, nor did I find any settings for it.


Current Yahoo does not send HTML attachments either, unless poster
WANTS to send HTML by activating "Allow HTML tags" thingie at
right underside of the message body entry box.  Turning that
off will not send HTML.  Plain and simple.

(Making these tests took me about an hour, most of the time to get
thru all those foobar verifiers.)



With Yahoo I had at first immense problems to get any email from them,
as their SMTP email sender uses INVALID protocol:

<<-  MAIL FROM: <yahoo-dev-null@yahoo-inc.com>
->>  501 5.1.7 strangeness between ':' and '<': <yahoo-dev-null@yahoo-inc.com>

When you read really carefully RFC 821 / 2821 syntax about that,
you will see that it does not allow space in that place.
Sendmail does, and that has forced others to extend the syntax alike.

That happens only during the registration if alternate address is given.
Actual web-mail sending works as it should.

Yahoo is the only legitimate email source doing that of what I have seen.
(Tons of spammers do it, of course.)


/Matti Aarnio  --  one of   co-postmasters of vger.kernel.org
