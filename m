Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDMVxJ>; Sat, 13 Apr 2002 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSDMVxI>; Sat, 13 Apr 2002 17:53:08 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:48908 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S310749AbSDMVxI>;
	Sat, 13 Apr 2002 17:53:08 -0400
Date: Sat, 13 Apr 2002 14:53:06 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Robert Love <rml@tech9.net>
Cc: mark manning <mark.manning@fastermail.com>, linux-kernel@vger.kernel.org
Subject: Re: nanosleep
Message-ID: <20020413145306.A29006@ecam.san.rr.com>
In-Reply-To: <20020410055708.9474.qmail@fastermail.com> <1018418496.903.228.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 02:01:35AM -0400, Robert Love wrote:
> On Wed, 2002-04-10 at 01:57, mark manning wrote:
> > hrm - im confiused now - how can you do a n NANO second delay when the
> > resolution is 10 mili seconds ?
> 
> Uh, you can't - that was his point.

Well there is a cheap trick if you catch what the man page says.
 
> You can try, and you will certainly sleep at least that long, but any
> time given modulo 10ms is out the door ...

Make all your calls to nanasleep be less than 2ms, and loop through as
many as you need until you are under 2ms.

Don't do it for too long because you get no other use out of your machine
while your doing this but it does work.
