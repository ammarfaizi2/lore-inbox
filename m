Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289230AbSA3PLg>; Wed, 30 Jan 2002 10:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSA3PL1>; Wed, 30 Jan 2002 10:11:27 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:29157
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S289243AbSA3PLO>; Wed, 30 Jan 2002 10:11:14 -0500
Date: Wed, 30 Jan 2002 16:11:05 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        killeri@iki.fi
Subject: Re: Wanted: Volunteer to code a Patchbot
Message-ID: <20020130161105.E9765@jaquet.dk>
In-Reply-To: <Pine.LNX.4.33.0201301306190.7674-100000@serv> <E16VumS-0000EM-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16VumS-0000EM-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Jan 30, 2002 at 02:28:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:28:04PM +0100, Daniel Phillips wrote:
>    Wanted: a scripting person who has a clue about MTAs and wants to 
>    contribute to the kernel.  Please step up to the table over here
>    and sign in blood, then we will tell you what your mission is.
>    Nobody will thank you for any of the work you do or reward you in
>    any way, except for the right to bask in the glory and fame of
>    being the one who ended the patchbot wars.  And maybe, just maybe
>    get that coveted Slashdot interview.
> 
> OK. that's it, if somebody bites I'll gladly participate in a design thread, 
> otherwise I think this is just going to sleep until the next bi-monthly 
> patchbot flameup.

I'll bite. I was noodling with this in the background already, so
I have some thoughts at home which I'll be happy to write up and
send to the list. Other people, notably John Weber (linuxhq)
and Patrick Mochel(? odsl) stated that they were working on
something too. As I dont do this for a living (dont mean to
imply that they are), I wouldn't want to want to be in the
way for the big boys :)

If I understand correctly, the bot would, in its basic incarnation,
accept patches (at patchbot@somewhere), stamp them with an uid,
and forward them to various places, e.g., lists, maintainers etc
and let the sumbitter know the patch uid. A mailing list archive
would then be the patch store. Basic filtering could be done by
the bot to reject non-patches etc.

The bot could also:
* Annotate patches with files touched.
* Try to apply patches and take action based on succces failure.
* Try to compile the resulting tree (based on a submitted .config)
  and take action based on the results.
* Store submissions locally and do the steps above for new
  kernel revisions, resubmtting them if appropriate.

Yes, the compile step kinda made the HW requirements go through
the roof.

I have some code already to handle some of this but typically,
I started at the wrong end and did the patch/compile stuff
first :) Ah, BTW, that is in python. I dont see a problem
with that.

Please comment but I may be offline till later this evening.

Regards,
  Rasmus

PS: Daniel have made me aware of another volunteer, Kalle
Kivimaa. I have added him to the list and could obviously
work with him.
