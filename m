Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281573AbRKMJ6j>; Tue, 13 Nov 2001 04:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281580AbRKMJ6f>; Tue, 13 Nov 2001 04:58:35 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:46852 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S281575AbRKMJ4s>; Tue, 13 Nov 2001 04:56:48 -0500
Message-ID: <3BF0EE66.FC5DA9CD@loewe-komp.de>
Date: Tue, 13 Nov 2001 10:56:54 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Mike Castle <dalgoda@ix.netcom.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <3BF04926.2080009@free.fr> <Pine.LNX.4.33.0111121411410.7555-100000@penguin.transmeta.com> <3BF04ED8.8A9280B5@zip.com.au> <20011112150420.B6749@thune.mrc-home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Castle wrote:
> 
> On Mon, Nov 12, 2001 at 02:36:08PM -0800, Andrew Morton wrote:
> >   /* Detect if outputting to "/dev/null".  */
> >   {
> >     static char const dev_null[] = "/dev/null";
> >     struct stat dev_null_stat;
> >
> >     dev_null_output =
> >       (strcmp (archive_name_array[0], dev_null) == 0
> >        || (! _isrmt (archive)
> >            && stat (dev_null, &dev_null_stat) == 0
> >            && S_ISCHR (archive_stat.st_mode)
> >            && archive_stat.st_rdev == dev_null_stat.st_rdev));
> >   }
> >
> > It's actually a bug.  I may _want_ an ISREG /dev/null...
> 
> Doesn't the S_ISCHR() handle that case?
> 

No. It is: if (A || B)
If A is true, B is not even evaluated.
