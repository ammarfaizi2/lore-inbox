Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKQU4f>; Fri, 17 Nov 2000 15:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKQU4Y>; Fri, 17 Nov 2000 15:56:24 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:50701 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id <S129199AbQKQU4L>; Fri, 17 Nov 2000 15:56:11 -0500
To: linux-kernel@vger.kernel.org
Path: kraxel
From: kraxel@bytesex.org (Gerd Knorr)
Newsgroups: lists.linux.kernel
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
Date: 17 Nov 2000 20:08:55 GMT
Organization: Strusel 007
Message-ID: <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <20001117013157.A21329@almesberger.net>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: goldbach.masq.in-berlin.de 974491735 3772 192.168.69.77 (17 Nov 2000 20:08:55 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 17 Nov 2000 20:08:55 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> The BTTV driver 0.7.48 doesn't detect my old Hauppauge card anymore.

Yes.  I've taken out the detection heuristics for bt848 cards.  The code
is very old, from the days where only 2-3 different bt848 cards where
available.  It simply did'nt work correctly and often used to misdetect
random bt848 cards as either MIRO or Hauppauge (which where the first
available cards).

> The problem seems to be that my card sets PCI_SUBSYSTEM_ID and
> PCI_SUBSYSTEM_VENDOR_ID to zero (lspci output below).

Only bt878 chips have a subsystem ID.  The bt848 has not.  That's why
there is simply no _reliable_ way to detect bt848 based cards.

  Gerd

-- 
Wirtschaftsinformatiker == Leute, die zwar die aktuellen Aktienkurse
jedes Softwareherstellers kennen, aber keines der Produkte auch nur
ansatzweise bedienen können.		-- Benedict Mangelsdorff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
