Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135813AbREBBS3>; Tue, 1 May 2001 21:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135924AbREBBST>; Tue, 1 May 2001 21:18:19 -0400
Received: from mailf.telia.com ([194.22.194.25]:25054 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S135813AbREBBSG>;
	Tue, 1 May 2001 21:18:06 -0400
Message-Id: <200105020117.f421H9F03748@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>
Subject: Re: 2.4 and 2GB swap partition limit
Date: Wed, 2 May 2001 03:14:33 +0200
X-Mailer: KMail [version 1.2.1]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105012143000.19012-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0105012143000.19012-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 May 2001 02:43, Rik van Riel wrote:
> On Tue, 1 May 2001, David S. Miller wrote:
> > Rik van Riel writes:
> >  > Then we will be scanning through memory looking for something to
> >  > swap out (otherwise we'd not be in need of swap space, right?).
> >  > At this point we can simply free up swap entries while scanning
> >  > through memory looking for stuff to swap out.
> >
> > Sounds a lot like my patch I posted a few weeks ago:
>
> Not really. Your patch only reclaims swap cache pages that
> hang around after a process exit()s. What I want to do is
> reclaim swap space of pages which have been swapped in so
> we can use that swap space to swap something else out.
>

We could reclaim swap space for dirty pages. They have to be
rewritten anyway...

Or would the fragmentation risk be too high?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
