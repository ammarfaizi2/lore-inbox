Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRJYTt6>; Thu, 25 Oct 2001 15:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276097AbRJYTts>; Thu, 25 Oct 2001 15:49:48 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:54670 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S276094AbRJYTtl>;
	Thu, 25 Oct 2001 15:49:41 -0400
Message-ID: <3BD86FA9.A992FE96@sun.com>
Date: Thu, 25 Oct 2001 13:01:45 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Matthew G. Marsh" <mgm@paktronix.com>
CC: David Ford <david@blue-labs.org>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        kuznet@ms2.inr.ac.ru, Julian Anastasov <ja@ssi.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <Pine.LNX.4.31.0110251234430.32029-100000@netmonster.pakint.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matthew G. Marsh" wrote:

> The original thought refers to the old concept of address "class" where is
> a "class" (think subnet) went away then there was no need (and indeed
> incorrect) behaviour to still be able to have addresses on it. Thus when
> the primary address is deleted you should clear all addresses within that

I don't really think the original thought matters.  What matters is that
the behavior is 
a) non-obvious - you don't expect it
b) undetectable - you can't find out which alias is "primary"
c) inconsistent - some aliases act differently that other aliases

All of these violate the principle of least surprise.  Whether it was
intentional or not, it behaves like a nasty hack, or worse, a bug.  It is
easily fixed, and should be.

> Again - if you do not like this behaviour do not use the primary/secondary
> addressing scopes. Use /32.

Why should user-land be forced to work around what is obviously (to the
vast majority of people in this discussion) a mis-feature?

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
