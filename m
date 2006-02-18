Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWBRQ66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWBRQ66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWBRQ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:58:58 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:57082 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932081AbWBRQ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:58:58 -0500
Message-ID: <BAYC1-PASMTP10F9FC737769E8EBCBF547AEF90@CEZ.ICE>
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Sat, 18 Feb 2006 11:58:02 -0500
From: sean <seanlkml@sympatico.ca>
To: Bill Davidsen <davidsen@tmr.com>
Cc: hch@infradead.org, dhazelton@enter.net, mrmacman_g4@mac.com,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060218115802.739dc947.seanlkml@sympatico.ca>
In-Reply-To: <43F74EE9.7070400@tmr.com>
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com>
	<233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com>
	<43EC83EC.nailISD91HRFF@burner>
	<200602090737.47747.dhazelton@enter.net>
	<20060210130228.GA30256@infradead.org>
	<43F63846.80109@tmr.com>
	<20060217210107.GA20411@infradead.org>
	<43F74EE9.7070400@tmr.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Feb 2006 16:59:54.0406 (UTC) FILETIME=[BD729460:01C634AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006 11:44:25 -0500
Bill Davidsen <davidsen@tmr.com> wrote:

> I'm sorry if I didn't make that clear. Some developers are saying that 
> the application shouldn't be finding devices because udev does that so 
> it doesn't matter that doing device location in the application is 
> complex and poorly defined because udev does it for you. I was making 
> the point that in the most common distributions (Fedora and SuSE) 
> pluggable burners don't get proper entries in /dev to make cdrecord 
> work. Based on a single report sent directly to me that seems to be the 
> case in ubuntu as well, but I haven't personally tried it.

For whatever its worth, every burner i've ever tried on a Fedora box has
just worked.   But you misunderstand, people aren't saying udev is the 
only answer; they're just saying device nodes must exist.  It's up to each
distro to decide how that happens; and then for user space to decide how 
those device nodes are passed to each application.

> I was refuting the claim that applications no longer need to find their 
> own devices; in many cases they do.

As has been shown, everything needed for device enumeration is already 
available to user space.  Completing the job of making device enumeration 
easy for applications remains for user space services such as HAL et. al.
not the kernel.

> Burning using the USB devices works fine if the right devices are found 
> and created.

Yes, and if any device isn't found and created properly it's a bug that
should be fixed, not something which can be used to support Joerg's archaic
ideas.

Sean
