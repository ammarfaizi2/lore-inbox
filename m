Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVo+9kMqsBTqeqSj2MWP4ApXua5g==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Fri, 02 Jan 2004 17:00:37 +0000
X-AuthUser: davidel@xmailserver.org
Message-ID: <001801c415a3$ef64cdf0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:38:51 +0100
From: "Davide Libenzi" <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@smtp.paston.co.uk>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
        <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040102071215.6D43C2C059@lists.samba.org>
MIME-Version: 1.0
Content-Class: urn:content-classes:message
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:38:51.0937 (UTC) FILETIME=[EFBF7110:01C415A3]

On Fri, 2 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0312311935080.5831-100000@bigblue.dev.mdolabs.com> yo
> u write:
> > On Wed, 31 Dec 2003, Rusty Russell wrote:
> > 
> > > But an alternate implementation would be to have a "kthread" kernel
> > > thread, which would actually be parent to the kthread threads.  This
> > > means it can allocate and clean up, since it catches *all* thread
> > > deaths, including "exit()".
> > > 
> > > What do you think?
> > 
> > Did you take a look at the stuff I sent you? I'll append here with a 
> > simple comment (this goes over you bits).
> 
> Yes, but I think it's a really bad idea, as I said before.
> 
> Anyway, Here's a version which fixes the issues raised by Andrew by
> doing *everything* in keventd, uses waitpid(), and uses signals for
> communication (except for the case of init failing).

Rusty, you still have to use global static data when there is no need. I 
like this version better though ;)



- Davide


