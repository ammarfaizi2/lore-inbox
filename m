Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273542AbRIYUlx>; Tue, 25 Sep 2001 16:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273552AbRIYUlo>; Tue, 25 Sep 2001 16:41:44 -0400
Received: from 50dyn47.com21.casema.net ([213.17.31.47]:7808 "HELO
	spaans.ds9a.nl") by vger.kernel.org with SMTP id <S273537AbRIYUlg>;
	Tue, 25 Sep 2001 16:41:36 -0400
Date: Tue, 25 Sep 2001 22:42:04 +0200
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pau Aliagas <linux4u@wanadoo.es>, lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roberto Orenstein <roberto@brsat.com.br>,
        Francois Romieu <romieu@cogenit.fr>
Subject: Re: [PATCH]  Re: 2.4.9-ac15 painfully sluggish
Message-ID: <20010925224204.A5968@spaans.ds9a.nl>
In-Reply-To: <Pine.LNX.4.33.0109251819520.1401-100000@pau.intranet.ct> <Pine.LNX.4.33L.0109251628460.26091-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109251628460.26091-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22i
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2001 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 04:32:13PM -0300, Rik van Riel wrote:

> > The problem seems to be related in pages not moved to swap but
> > being discarded somehow and reread later on.... just a guess.
> 
> I've made a small patch to 2.4.9-ac15 which should make
> page_launder() smoother, make some (very minor) tweaks
> to page aging and updates various comments in vmscan.c
> 
> It's below this email and at:
[snip]

With this -painfully applied- patch, all seems a lot better. However, it
still seems more sluggish than 2.4.9-ac12.

Haven't bothered testing -ac13 and -ac14.

Swapping still seems to be a problem though, as this kernel happily claims
several tens of MBs of swap, and then, out of the blue, starts writing pages
out in huge blocks.

The vmstat info just disappeared from my screen, while stressing the
vm-system by doing a large parallel build, however, it showed no paging
happening during long times (20-30 secs) and then suddenly writing 30 MB in
one go.

Doesn't seem very smooth to me, where can I get my refund? :)

(if you'd like more details, please ask, I can do some testing)

Regards,
-- 
  Q_.           Jasper Spaans <jasper@spaans.ds9a.nl>
 `~\            http://jsp.ds9a.nl/
Mr /\           Tel/Fax: +31-84-8749842
Zap             Move '.sig' for great justice!
