Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbRADSAs>; Thu, 4 Jan 2001 13:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRADSAi>; Thu, 4 Jan 2001 13:00:38 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:1246 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129557AbRADSAZ>; Thu, 4 Jan 2001 13:00:25 -0500
From: David Lang <david.lang@digitalinsight.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Date: Thu, 4 Jan 2001 10:00:01 -0800 (PST)
Subject: Re: Journaling: Surviving or allowing unclean shutdown? 
In-Reply-To: <10290.978630745@redhat.com>
Message-ID: <Pine.LNX.4.31.0101040954040.10387-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in an enbedded device you can

1. setup the power switch so it doesn't actually turn things off (it
issues the shutdown command instead)

2.  run from read-only media almost exclusivly so that power event's don't
bother you much

3. you can add extra power inside the device so that if someone does pull
the plug, you have a few seconds of power to do the clean shutdown

4. you can run out of ram and force the user to do an extra step to save
any changes to non-volitile storage (and if they power off during the save
the results are undefined)

I have seen all of these approaches used in different devices (that are
not running linux). This is not a new problem and the people working in
this space have a bunch of answers.

an improved filesystem that tolorates bad shutdowns reasonably well will
be welcomed for other reasons, but should not be viewed as a fix for
people pulling the plug on you.

David Lang



On Thu, 4 Jan 2001, David Woodhouse wrote:

> Date: Thu, 04 Jan 2001 17:52:25 +0000
> From: David Woodhouse <dwmw2@infradead.org>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Daniel Phillips <phillips@innominate.de>,
>      Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
> Subject: Re: Journaling: Surviving or allowing unclean shutdown?
>
>
> david.lang@digitalinsight.com said:
> > for crying out loud, even windows tells the users they need to
> > shutdown first and gripes at them if they pull the plug. what users
> > are you trying to protect, ones to clueless to even run windows?
>
> Precisely. Users of embedded devices don't expect to have to treat them
> like computers.
>
> --
> dwmw2
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
