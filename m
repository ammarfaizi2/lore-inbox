Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSLVBCC>; Sat, 21 Dec 2002 20:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSLVBCC>; Sat, 21 Dec 2002 20:02:02 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:48070 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264639AbSLVBCB>; Sat, 21 Dec 2002 20:02:01 -0500
Message-ID: <20021222010959.24200.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, arashi@arashi.yi.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 22 Dec 2002 09:09:59 +0800
Subject: Re: 2.5.52, load and process in D state
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>
> Paolo Ciarrocchi wrote:
> > 
> > Hi all,
> > I booted 2.5.52 with the following parmater:
> > apm=off mem=32M (not sure about the amount, anyway I can reproduce
> > the problem for sure with 32M and 40M)
> > 
> > Then I tried the osdb (www.osdb.org) benchmark with
> > 40M of data.
> > 
> > $./bin/osdb-pg --nomulti
> > 
> > the result is that aftwer a few second running top I see the postmaster
> > process in D state and a lot if iowait.
> 
> What exactly _is_ the issue?  The machine is achieving 25% CPU utilisation
> in user code, 6-9% in system code.  It is doing a lot of I/O, and is
> getting work done.

The issue it that with 2.4.19 the postmaster process never go in D state
and iowait always reports 0%.
Sounds strange with me.

Ciao,
       Paolo 

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
