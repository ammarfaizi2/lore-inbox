Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264980AbSJWN1T>; Wed, 23 Oct 2002 09:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264981AbSJWN1T>; Wed, 23 Oct 2002 09:27:19 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:61078 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S264980AbSJWN1R> convert rfc822-to-8bit;
	Wed, 23 Oct 2002 09:27:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: bert hubert <ahu@ds9a.nl>
Subject: Re: [RESEND] tuning linux for high network performance?
Date: Wed, 23 Oct 2002 15:41:02 +0200
User-Agent: KMail/1.4.1
Cc: netdev@oss.sgi.com, Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <200210231306.18422.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl>
In-Reply-To: <20021023130101.GA646@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231541.02883.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> '50 clients *each* streaming at ~4.4MBps', better make that clear,
> otherwise something is *very* broken. Also mention that you have an e1000
> card which does not do outgoing checksumming.

just to clearify

s/MBps/Mbps/
s/bps/bits per second/

> You'd think that a kernel would be able to do 250megabits of TCP checksums
> though.
>
> > ...adding the whole profile output - sorted by the first column this
> > time...
> >
> > 905182 total                                      0.4741
> > 121426 csum_partial_copy_generic                474.3203
> >  93633 default_idle                             1800.6346
> >  74665 do_wp_page                               111.1086
>
> Perhaps the 'copy' also entails grabbing the page from disk, leading to
> inflated csum_partial_copy_generic stats?

I really don't know. Just to clearify a little more - the server app uses 
O_DIRECT to read the data before tossing it to the socket.

> Where are you serving from?

What do you mean?

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

