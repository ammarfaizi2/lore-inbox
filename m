Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135933AbRDTOWN>; Fri, 20 Apr 2001 10:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135924AbRDTOWE>; Fri, 20 Apr 2001 10:22:04 -0400
Received: from tango.SoftHome.net ([204.144.231.49]:9089 "HELO
	tango.SoftHome.net") by vger.kernel.org with SMTP
	id <S135929AbRDTOVr>; Fri, 20 Apr 2001 10:21:47 -0400
Message-ID: <040201c0c9a5$87d05c60$7253e59b@megatrends.com>
From: "Venkatesh Ramamurthy" <venkateshr@softhome.net>
To: "Stephen C. Tweedie" <sct@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>, "Stephen Tweedie" <sct@redhat.com>
In-Reply-To: <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl> <9bi53d$5n6$1@cesium.transmeta.com> <20010420131357.B1444@redhat.com>
Subject: Re: RFC: pageable kernel-segments
Date: Fri, 20 Apr 2001 10:23:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > VMS does this.  It at least used to have a great tendency to crash
> > itself, because it swapped out something that was called from a driver
> > that was called by the swapper -- resulting in deadlock.  You need
> > iron discipline for this to work right in all circumstances.
>
> Actually, VMS doesn't do this, precisely because it is so hard to get
> right.  VMS has both paged and non-paged pools for dynamically
> allocated kernel memory, but the kernel code itself is non-pageable.

[Venkat] This [pageable drivers] has been a nightware for NT (derived from
VMS) driver programmers. It almost divides the set of kernel API into two
halves, one which can be called at any IRQL and the other only at elevated
irql. The benefits of having pageable kernel pages is very minimal when
compared to the complexity that gets added to the kernel. We can keep the
kernel simpler(and faster) without having parts of drivers pageable. But one
more issue is having the page tables pageable.......




