Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274580AbRIYJlx>; Tue, 25 Sep 2001 05:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274579AbRIYJlo>; Tue, 25 Sep 2001 05:41:44 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63478
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274580AbRIYJlg>; Tue, 25 Sep 2001 05:41:36 -0400
Date: Tue, 25 Sep 2001 02:41:57 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.2.20-pre10 Initial Impressions
Message-ID: <20010925024157.E8738@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BAC8E1C.2201.524EE2@localhost> <3BAE3F75.665.75F16A@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAE3F75.665.75F16A@localhost>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 08:00:53PM -0500, John L. Males wrote:
Content-Description: Mail message body
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Alan,
> 
> Test Case One:
> ****************
> 
> - - Start Netscape 4.78 from desktop ICON
> - - Click the pull down arrow on far right side of the "Go To:" (AKA
> URL line) of Netscape 4.78.
> 
> Results:
> All were instant response from Netscape.  Did the test for each

> Test Case Two:
> *****************
> 
> Steps used:
> 
> - - Boot System
> - - Log onto non-root user id.
> - - "startx" (KDE desktop started)
> (applications prestart from last log off include kppp, kpppload,
> xosview, gnome terminal, khrono, 3 kfm's)
> - - Had kppp "connect" to my ISP (dial up model 56KB, really 49,300
> most of time, some connects 48,000, note kppp is configured to start
> up ntpdate to sync with some time servers.)
> - - Start Netscape 4.78 from desktop ICON
> - - Click the pull down arrow on far right side of the "Go To:" (AKA
> URL line) of Netscape 4.78.
> 
> Results:
> 
> For Kernel 2.2.19OWL, 2.2.20-pre10, 2.4.9-ac10
> 
> All times were 2 minutes 3 seconds to get the URL list that appears
> 
> 

> Test Case Three:
> *******************
> 
> For the two times this test case was also done, still a delay of 2
> minutes 3 seconds from the time clicked the button until the URLs
> appeared.

> Test Case Four:
> ******************
> 
> For the one time I did this test case, a delay of 2 minutes 19
> seconds from the time clicked the button until the URLs appeared.
> 
> 

> Test Case Five:
> *****************
> For Kernel 2.2.19OWL only was this test done.  First time the delay
> was 2 minutes 3 seconds, the second time it was 2 minutes 15 seconds.
> 
> 

I think you're right, it's not a kernel issue.  You should run "tcpdump -qni
ppp0" in a xterm before you start netscape.

You will probably see dns requests going out.  You should check to make sure
that you are not blocking incomming udp ports (1024-5000 for bind, not sure
about resolver...) as that would lengthen the response time considerably if
only a few are open, and completely stop you if all are blocked.

Mike
