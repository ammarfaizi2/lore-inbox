Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpA4xuvGlmne4QGiOjhPG5gwPmg==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 03:45:58 +0000
Message-ID: <00aa01c415a4$0e315370$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-AuthUser: davidel@xmailserver.org
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:39:43 +0100
From: "Davide Libenzi" <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: <Administrator@osdl.org>
Content-Class: urn:content-classes:message
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
        <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040103030802.BD1DB2C06E@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:44.0265 (UTC) FILETIME=[0EF00F90:01C415A4]

On Sat, 3 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> you write:
> > Rusty, you still have to use global static data when there is no need.
> 
> And you're still putting obscure crap in the task struct when there's
> no need.  Honestly, I'd be ashamed to post such a patch.

Ashamed !? Take a look at your original patch and then define shame. You 
had a communication mechanism that whilst being a private 1<->1 
communication among two tasks, relied on a single global message 
strucure, lock and mutex. Honestly I do not like myself to add stuff 
inside a strcture for one-time use. Not because of adding 12 bytes to the 
struct, that are laughable. But because it is used by a small piece of 
code w/out a re-use ability for other things.



> > I like this version better though ;)
> 
> I think I should seek a second opinion though.

But of course, even a third one ;)



- Davide




