Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbTDLJgP (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbTDLJgP (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:36:15 -0400
Received: from khms.westfalen.de ([62.153.201.243]:28632 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP id S263216AbTDLJgO (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 05:36:14 -0400
Date: 12 Apr 2003 10:22:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8jkHLjRXw-B@khms.westfalen.de>
In-Reply-To: <200304110919_MC3-1-33FD-6E7@compuserve.com>
Subject: Re: kernel support for non-English user messages
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <200304110919_MC3-1-33FD-6E7@compuserve.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

76306.1226@compuserve.com (Chuck Ebbert)  wrote on 11.04.03 in <200304110919_MC3-1-33FD-6E7@compuserve.com>:

> Linux Torvalds wrote:
>
>
> > I've used VMS, and error code number encoding is a total heap of crap.
>
>
>  Maybe for developers, but users like it.  I can still remember back in
> the Old Days, taking those error codes and looking them up in something
> called a "manual" where there was a coherent explanation of
> what had gone wrong and even suggestions on what to do about it.

I think that's the real point here: without a manual to look things up in,  
none of this actually buys us anything.

The grepme file someone proposed seems to be a reasonable first step,  
starting to number or otherways add a code to everything doesn't - it may  
or may not be a reasonable thing after there is experience with the grepme  
file, but we don't have that experience right now so we don't know.

Oh, yes: one thing *might* make sense: have a script to extract kernel  
messages, and have source conventions to support that script, such as:
* when a message is built with more than one statement, some way to figure  
out where it starts and ends.
* a way to attach a comment that can be extracted by that script as an  
explanation of the message.




(Which makes me think it might be a nice gcc extension (in general, not  
necessarily for the above thing - actually, probably not for that, so take  
this as an unrelated aside) to have function-relative line numbers  
available as some sort of symbol. __FUNCTION__ (or __PRETTY_FUNCTION__)  
together with that (and possibly __FILE__) would make a semi-stable  
identifier - it only changes when that function is changed, as opposd to  
when anything is changed that happens to be before that function in the  
same source. Of course, many variations of that idea are imaginable.)

MfG Kai
