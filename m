Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVo/uQ5loypE5SSTm99Fh5hqzeiA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Fri, 02 Jan 2004 20:40:50 +0000
Message-ID: <004801c415a3$fb90f450$d100000a@sbs2003.local>
Date: Mon, 29 Mar 2004 16:39:11 +0100
Content-Transfer-Encoding: 7bit
From: "Joe Korty" <joe.korty@ccur.com>
To: <Administrator@smtp.paston.co.uk>
Cc: <akpm@osdl.org>, <ak@suse.de>, <linux-kernel@vger.kernel.org>,
        <albert.cahalan@ccur.com>, <jim.houston@ccur.com>
X-Mailer: Microsoft CDO for Exchange 2000
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
Reply-To: "Joe Korty" <joe.korty@ccur.com>
References: <20040102194909.GA2990@rudolph.ccur.com> <Pine.LNX.4.58.0401021226150.5282@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Class: urn:content-classes:message
Content-Disposition: inline
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: <Pine.LNX.4.58.0401021226150.5282@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:12.0437 (UTC) FILETIME=[FBF77E50:01C415A3]

[ resend, accidently sent originally from a broken email account ]

> On Fri, 2 Jan 2004, Joe Korty wrote:
>> siginfo_t processing is fragile when in 32 bit compatibility mode on
>> a 64 bit processor.
> 
> It shouldn't be.
> Inside the kernel, we should always use the "native" format (ie 64-bit). 

Indeed we do, and that is the problem.  32 bit apps by definition use
the 32 bit version of siginfo_t and the first act the kernel has to do
on receiving one of these is convert it to 64 bit for consumption by
the rest of the kernel.  In order to do that, the kernel must know what
fields in siginfo_t the user has set.

Joe

