Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264803AbRFSVsh>; Tue, 19 Jun 2001 17:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264802AbRFSVsR>; Tue, 19 Jun 2001 17:48:17 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4503 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S264801AbRFSVsM>;
	Tue, 19 Jun 2001 17:48:12 -0400
Message-ID: <3B2FC899.3F0105F1@mandrakesoft.com>
Date: Tue, 19 Jun 2001 17:48:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomasz =?iso-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre4
In-Reply-To: <E15CS0l-0006co-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > On Tue, 19 Jun 2001, Alan Cox wrote:
> > [..]
> > > o   Fix refclock build with newer gcc               (Jari Ruusu)
> >
> > Is it mean now kernel 2.2 with prepatch is (or will be) gcc 3.0 ready ?
> > If not what must be fixed/chenged to be ready ?
> 
> It wont build with gcc 3.0 yet. To start with gcc 3.0 will assume it can
> insert calls to 'memcpy'

IMHO omitting -fno-builtin when compiling the kernel was always a risky
proposition...  Since we provide our own copies of many of the builtins
[which are used in the kernel] anyway... why not always -fno-builtin,
and then call __builtin_foo when we really want the compiler's version..

gcc 3.0 without -fno-builtin is perfectly allowed to assume it can
insert calls to memcpy..

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
