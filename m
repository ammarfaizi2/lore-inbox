Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVo/uo4AnpDaJvRwCKMoT6Ow3X+w==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Fri, 02 Jan 2004 20:49:33 +0000
Message-ID: <005e01c415a3$fba8c210$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:39:11 +0100
From: "Linus Torvalds" <torvalds@osdl.org>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@smtp.paston.co.uk>
Cc: <akpm@osdl.org>, <ak@suse.de>, <linux-kernel@vger.kernel.org>,
        <albert.cahalan@ccur.com>, <jim.houston@ccur.com>
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
In-Reply-To: <20040102203820.GA3147@rudolph.ccur.com>
Content-Class: urn:content-classes:message
References: <20040102194909.GA2990@rudolph.ccur.com> <Pine.LNX.4.58.0401021226150.5282@home.osdl.org> <20040102203820.GA3147@rudolph.ccur.com>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:13.0859 (UTC) FILETIME=[FCD07930:01C415A3]



On Fri, 2 Jan 2004, Joe Korty wrote:
>
> Indeed we do, and that is the problem.  32 bit apps by definition use
> the 32 bit version of siginfo_t and the first act the kernel has to do
> on receiving one of these is convert it to 64 bit for consumption by
> the rest of the kernel.  In order to do that, the kernel must know what
> fields in siginfo_t the user has set.

Ahh, a light goes on. Yeah, that's broken. Argh.

		Linus
