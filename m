Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132347AbQKSIzr>; Sun, 19 Nov 2000 03:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132358AbQKSIz1>; Sun, 19 Nov 2000 03:55:27 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:46865 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id <S132347AbQKSIzS>; Sun, 19 Nov 2000 03:55:18 -0500
To: linux-kernel@vger.kernel.org
Path: kraxel
From: kraxel@bytesex.org (Gerd Knorr)
Newsgroups: lists.linux.kernel
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
Date: 19 Nov 2000 08:24:27 GMT
Organization: Strusel 007
Message-ID: <slrn91f3hr.jt.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <20001117013157.A21329@almesberger.net> <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de> <20001118141426.B23033@almesberger.net>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: goldbach.masq.in-berlin.de 974622267 11183 192.168.69.77 (19 Nov 2000 08:24:27 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 19 Nov 2000 08:24:27 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Gerd Knorr wrote:
> > It simply did'nt work correctly and often used to misdetect
> > random bt848 cards as either MIRO or Hauppauge (which where the first
> > available cards).
> 
> Well, this means there's yet another mandatory __setup parameter :-(

Why?  What is the point in compiling bttv statically into the kernel?
Unlike filesystems/ide/scsi/... you don't need it to get the box up.
No problem to compile the driver as module and configure it with
/etc/modules.conf ...

> Should it be called bttv_card or bt484_card (i.e. are there cases
> where a user would want to override the card detection for non-848
> bttv cards ?)

Yes.  Some bt878 cards don't have a ID, and there are a few cases
where different cards have the same subsystem ID.

  Gerd

-- 
Wirtschaftsinformatiker == Leute, die zwar die aktuellen Aktienkurse
jedes Softwareherstellers kennen, aber keines der Produkte auch nur
ansatzweise bedienen können.		-- Benedict Mangelsdorff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
