Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281461AbRKPQxe>; Fri, 16 Nov 2001 11:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281462AbRKPQxY>; Fri, 16 Nov 2001 11:53:24 -0500
Received: from [64.92.133.94] ([64.92.133.94]:44296 "HELO boxxtech.com")
	by vger.kernel.org with SMTP id <S281461AbRKPQxL>;
	Fri, 16 Nov 2001 11:53:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@boxxtech.com>
Reply-To: mjustice@boxxtech.com
Organization: BOXX Technologies, Inc.
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
Subject: Re: Tuning Linux for high-speed disk subsystems
Date: Fri, 16 Nov 2001 10:53:05 -0600
X-Mailer: KMail [version 1.3.1]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B6867E6CB09B24385A73719A50C7C9A79791F@athena.boxxtech.com>
In-Reply-To: <3B6867E6CB09B24385A73719A50C7C9A79791F@athena.boxxtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200111161048890.SM01008@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As I count your disks may be the double for the best case. I read here on
>  LKML a post that someone claims that W2k deliever 250 MB/s with such a
>  configuration. Linux 2.4 should do the same. Ask the SCSI gurus.
>

That may have been my post you refer to. With 2x5 disks, each capable of
50 MB/s by itself, we can stream 255 MB/s very smoothly in either direction 
with W2K --- as long as FILE_FLAG_NOBUFFER is used. With standard
reads the number is more like 100 MB/s if I recall correctly, so the buffer
cache can definitely get in the way.

With Linux + XFS I was getting 250 MB/s read and 220 MB/s write (with a
bit less smoothness than W2K) using O_DIRECT and no high mem to avoid
bounce buffer copies. Using standard reads the numbers drop to around 
120 MB/s. That was a couple of weeks ago and I want to try tweaking some
more but a co-worker has "borrowed" pieces of the hardware for the moment.

-- 
Marvin Justice
Software Developer
BOXX Technologies
www.boxxtech.com
mjustice@boxxtech.com
512-235-6318 (V)
512-835-0434 (F)
