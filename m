Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbREHSU3>; Tue, 8 May 2001 14:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133088AbREHSUU>; Tue, 8 May 2001 14:20:20 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:43535 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S133062AbREHSUN>; Tue, 8 May 2001 14:20:13 -0400
Date: 08 May 2001 19:59:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80VZCMhHw-B@khms.westfalen.de>
In-Reply-To: <200105071452.f47Eq2jn008611@pincoya.inf.utfsm.cl>
Subject: Re: page_launder() bug
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <davem@redhat.com> <15094.10942.592911.70443@pizda.ninka.net> <200105071452.f47Eq2jn008611@pincoya.inf.utfsm.cl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vonbrand@inf.utfsm.cl (Horst von Brand)  wrote on 07.05.01 in <200105071452.f47Eq2jn008611@pincoya.inf.utfsm.cl>:

> "David S. Miller" <davem@redhat.com> said:
> > Jonathan Morton writes:
> >  > >-			 page_count(page) == (1 + !!page->buffers));
> >  >
> >  > Two inversions in a row?
> >
> > It is the most straightforward way to make a '1' or '0'
> > integer from the NULL state of a pointer.
>
> IMVHO, it is clearer to write:
>
>   page_count(page) == 1 + (page->buffers != NULL)
>
> At least, the original poster wouldn't have wondered, and I wouldn't have
> had to think a bit to find out what it meant... If gcc generates worse code
> for this, it should be fixed.

Huh. IMO, that is significantly *less* readable. And incidentally I'd be  
less certain that it actually does what you want - it is rather easy to  
convince yourself that !! has to do the right thing.

MfG Kai
