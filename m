Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbRE2FAy>; Tue, 29 May 2001 01:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbRE2FAo>; Tue, 29 May 2001 01:00:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7138 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263211AbRE2FAb>;
	Tue, 29 May 2001 01:00:31 -0400
Message-ID: <3B1327D5.6484E61E@mandrakesoft.com>
Date: Tue, 29 May 2001 00:38:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
Cc: safemode <safemode@voicenet.com>, "G. Hugh Song" <ghsong@kjist.ac.kr>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM...
In-Reply-To: <200105290232.f4T2W9m00876@bellini.kjist.ac.kr> <20010529061039.D29962@unthought.net> <01052900260800.29037@psuedomode>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 29 May 2001 00:10, Jakob Østergaard wrote:
> 
> > > > Mem: 381608K av, 248504K used, 133104K free, 0K shrd, 192K
> > > > buff
> > > > Swap: 255608K av, 255608K used, 0K free 215744K
> > > > cached
> > > >
> > > > Vanilla 2.4.5 VM.
> 
> > It's not a bug.  It's a feature.  It only breaks systems that are run with
> > "too little" swap, and the only difference from 2.2 till now is, that the
> > definition of "too little" changed.

I am surprised as many people as this are missing,

* when you have an active process using ~300M of VM, in a ~380M machine,
2/3 of the machine's RAM should -not- be soaked up by cache

* when you have an active process using ~300M of VM, in a ~380M machine,
swap should not be full while there is 133M of RAM available.

The above quoted is top output, taken during the several minutes where
cc1plus process was ~300M in size.  Similar numbers existed before and
after my cut-n-paste, so this was not transient behavior.

I can assure you, these are bugs not features :)

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
