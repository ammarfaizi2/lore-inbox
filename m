Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131367AbQLLAhM>; Mon, 11 Dec 2000 19:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131385AbQLLAhD>; Mon, 11 Dec 2000 19:37:03 -0500
Received: from mx1.hcvlny.cv.net ([167.206.112.76]:63742 "EHLO
	mx1.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S131367AbQLLAgq>; Mon, 11 Dec 2000 19:36:46 -0500
To: James Simmons <jsimmons@suse.com>
Cc: Pavel Machek <pavel@suse.cz>,
        "Frédéric L . W . Meunier" <0@pervalidus.net>,
        linux-kernel@vger.kernel.org
Subject: Re: SysRq behavior
In-Reply-To: <Pine.LNX.4.21.0012111440460.296-100000@euclid.oak.suse.com>
From: Alan Shutko <ats@acm.org>
Date: 11 Dec 2000 19:05:48 -0500
In-Reply-To: <Pine.LNX.4.21.0012111440460.296-100000@euclid.oak.suse.com>
Message-ID: <871yve4i77.fsf@wesley.springies.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@suse.com> writes:

> Just played with this bug. It doesn't kill a login shell but does any
> app running on it. I just went looking for where "Quit" is printed
> out. When I press SysRq Quit is printed on the command line. Any ideas?

Not a bug.  Normally,. PrtSc will generate a ^\, which is the default
value of stty quit.  Try

stty quit ^A
cat

and hit PrtSc

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
If you have to think twice about it, you're wrong.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
