Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129945AbRCAUfO>; Thu, 1 Mar 2001 15:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbRCAUeA>; Thu, 1 Mar 2001 15:34:00 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5380 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129957AbRCAUdR>;
	Thu, 1 Mar 2001 15:33:17 -0500
Date: Sat, 1 Jan 2000 02:02:13 +0000
From: Pavel Machek <pavel@suse.cz>
To: Bill Crawford <billc@netcomuk.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
Message-ID: <20000101020213.D28@(none)>
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk>; from billc@netcomuk.co.uk on Thu, Feb 22, 2001 at 11:08:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  I was hoping to point out that in real life, most systems that
> need to access large numbers of files are already designed to do
> some kind of hashing, or at least to divide-and-conquer by using
> multi-level directory structures.

Yes -- because their workaround kernel slowness.

I had to do this kind of hashing because kernel disliked 70000 html
files (copy of train time tables).

BTW try rm * with 70000 files in directory -- command line will overflow.

>  A particular reason for this, apart from filesystem efficiency,
> is to make it easier for people to find things, as it is usually
> easier to spot what you want amongst a hundred things than among
> a thousand or ten thousand.

Yes? Easier to type cat timetab1/2345 that can timetab12345? With bigger
command line size, putting i into *one& directory is definitely easier.


>  A couple of practical examples from work here at Netcom UK (now
> Ebone :), would be say DNS zone files or user authentication data.
> We use Solaris and NFS a lot, too, so large directories are a bad
> thing in general for us, so we tend to subdivide things using a
> very simple scheme: taking the first letter and then sometimes
> the second letter or a pair of letters from the filename.  This
> actually works extremely well in practice, and as mentioned above
> provides some positive side-effects.

Positive? Try listing all names that contain "linux" with such case. I'll
do ls *linux*. You'll need ls */*linux* ?l/inux* li/nux*. Seems ugly to
me.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

