Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291384AbSBGWb7>; Thu, 7 Feb 2002 17:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291355AbSBGWbl>; Thu, 7 Feb 2002 17:31:41 -0500
Received: from h108-129-61.datawire.net ([207.61.129.108]:34065 "HELO
	mail.datawire.net") by vger.kernel.org with SMTP id <S291378AbSBGWaY>;
	Thu, 7 Feb 2002 17:30:24 -0500
Subject: Re: Problem with rmap-12c
From: Shawn Starr <shawn.starr@datawire.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202072006010.17850-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202072006010.17850-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 07 Feb 2002 17:32:49 -0500
Message-Id: <1013121170.226.0.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do :)

I've been noticing those same results. 

Shawn.

On Thu, 2002-02-07 at 17:12, Rik van Riel wrote:
> On 7 Feb 2002, Louis Garcia wrote:
> 
> > I tried rmap-12c and had lots of swap usage. I when back to 12a and
> > everything calmed down. Is their a known problem with 12c?
> 
> Nope, but the RSS limit enforcing stuff is a possible
> suspect.
> 
> It turns out I used a "struct pte_t" in over_rss_limit(),
> which turned into a compiler warning, for which I didn't
> spot the cause ;)
> 
> A fix for the bug was sent by Roger Larsson, who spotted
> the fact that "pte_t" already has a "struct" inside it.
> 
> Maybe page aging isn't working in rmap-12c because of this
> stupid mistake ... but it's a long shot.  Maybe I should
> release rmap 12d tonight ? ;)
> 
> regards,
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Shawn Starr
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
8

