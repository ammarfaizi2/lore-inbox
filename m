Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283803AbRLITTb>; Sun, 9 Dec 2001 14:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283805AbRLITTW>; Sun, 9 Dec 2001 14:19:22 -0500
Received: from unthought.net ([212.97.129.24]:8594 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S283803AbRLITTB>;
	Sun, 9 Dec 2001 14:19:01 -0500
Date: Sun, 9 Dec 2001 20:19:00 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Chris Friesen <chris_friesen@sympatico.ca>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: software raid issues -- possible kernel I/O problem?
Message-ID: <20011209201900.A8549@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Chris Friesen <chris_friesen@sympatico.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C11358D.28400117@sympatico.ca> <3C114539.62A0D8E7@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3C114539.62A0D8E7@sympatico.ca>; from chris_friesen@sympatico.ca on Fri, Dec 07, 2001 at 05:39:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 05:39:53PM -0500, Chris Friesen wrote:
> 
> A number of people have privately pointed out that hdparm -T doesn't
> actually go to the disk at all.  Guess I should RTFM...I though that
> this was reading from the disk's cache, not linux's cache.  Oops.
> 
> I'm still kind of curious why raid-1 reads don't seem to get any
> performance increase over reads from a single disk.  Any ideas?

For one single large sequential read, the current RAID-1 code will
not show any significant benefit over the single-disk case.

However, if you read many smaller files, or have multiple concurrent
readers, you should see a good speedup.

Try running two bonnies at the same time.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
