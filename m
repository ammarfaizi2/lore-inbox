Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289708AbSAOWqh>; Tue, 15 Jan 2002 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289711AbSAOWq1>; Tue, 15 Jan 2002 17:46:27 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:22442 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289708AbSAOWqP>;
	Tue, 15 Jan 2002 17:46:15 -0500
Date: Tue, 15 Jan 2002 22:46:11 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Tom Rini <trini@kernel.crashing.org>,
        Justin Carlson <justincarlson@cmu.edu>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
Message-ID: <197055869.1011134770@[195.224.237.69]>
In-Reply-To: <20020115013025.GA3814@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020115013025.GA3814@cpe-24-221-152-185.az.sprintbbd.net>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> From the other side, how does having the ability to probe local hardware
>> hurt?  It should be cleanly seperable from the classical build process
>> for the purists, and helpful to some (I think) significant portion of
>> the userbase, particularly those folks who like to test bleeding edge
>> stuff on a variety of hardware.  I don't really understand the
>> resistance to the idea of someone going out and implementing this.
>
> Right, and this is 95% possible even.  Doing PCI stuff is rather easy
> (since we've got it all mapped out even).  The problem is the 100%
> point-click-run goal that Eric has.
>
> The original sticking point was doing ISA (and other buses that are
> _not_ autodetect friendly in a safe way).

& this has a seemingly obvious solution, which is, if the autoprobe
stuff is selected, and, after presentation of the initial list
of drivers, plus comments like 'Network card: none', 'Sound card: none',
say 'We may have missed some stuff if you have an old computer, press
Y if what we've detected doesn't find all your hardware', and if
they press Y (only), select as modules every ISA driver except
those, which when loaded on a system not containing the relevant
card, can cause a hangup; thus deferring the autoprobing until
boot time.

--
Alex Bligh
