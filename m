Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281165AbRKLXEs>; Mon, 12 Nov 2001 18:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKLXEh>; Mon, 12 Nov 2001 18:04:37 -0500
Received: from marine.sonic.net ([208.201.224.37]:52024 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S281161AbRKLXE2>;
	Mon, 12 Nov 2001 18:04:28 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 12 Nov 2001 15:04:21 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011112150420.B6749@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BF04926.2080009@free.fr> <Pine.LNX.4.33.0111121411410.7555-100000@penguin.transmeta.com> <3BF04ED8.8A9280B5@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF04ED8.8A9280B5@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 02:36:08PM -0800, Andrew Morton wrote:
>   /* Detect if outputting to "/dev/null".  */
>   {
>     static char const dev_null[] = "/dev/null";
>     struct stat dev_null_stat;
> 
>     dev_null_output =
>       (strcmp (archive_name_array[0], dev_null) == 0
>        || (! _isrmt (archive)
>            && stat (dev_null, &dev_null_stat) == 0
>            && S_ISCHR (archive_stat.st_mode)
>            && archive_stat.st_rdev == dev_null_stat.st_rdev));
>   }
> 
> It's actually a bug.  I may _want_ an ISREG /dev/null...

Doesn't the S_ISCHR() handle that case?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
