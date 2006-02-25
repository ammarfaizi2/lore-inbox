Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWBYKtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWBYKtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 05:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWBYKtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 05:49:52 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:58613 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030199AbWBYKtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 05:49:51 -0500
Date: Sat, 25 Feb 2006 05:49:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
In-reply-to: <20060225084139.GB22109@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       okir@suse.de
Reply-to: gene.heskett@verizononline.net
Message-id: <200602250549.47547.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <43FF88E6.6020603@linux.intel.com>
 <20060225084139.GB22109@infradead.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 03:41, Christoph Hellwig wrote:
>On Fri, Feb 24, 2006 at 04:29:58PM -0600, James Ketrenos wrote:
>> As a result of this change, some of the capabilities currently
>> required to be provided on the host include enforcement of
>> regulatory limits for the radio transmitter (radio calibration,
>> transmit power, valid channels, 802.11h, etc.) In order to meet the
>> requirements of all geographies into which our adapters ship (over
>> 100 countries) we have placed the regulatory enforcement logic into
>> a user space daemon that we provide as a binary under the same
>> license agreement as the microcode.  We provide that binary
>> pre-compiled as both a 32-bit and
>
>the regualatory problems are not true.  they are completely focused on
>the users.  Someone who wants to change it can always do it, may it be
>by binary patching.  I don't know of a single country that forbids
>implementing those bits in source code shipped, and in those countries
>we alredy couldn't distribute the kernel.
>
>A binary daemon is completely unacceptable and unless you fix that
> there is zero chance the driver could get into mainline.  I'd also
> like to urge the distributors to not put this crap in to weaken our
> free drivers future.  Intel, please stop this madness and play by the
> rules.

As someone (a broadcast engineer with 40+ years of carrying what used to 
be a 1st phone) obviously more familiar with the FCC R&R than you 
apparently are, Christoph, I'll have to argue that point.  Intel has no 
legal choice in the matter because the FCC had decreed that the stuff 
to enforce the radiation limits either has to be in a custom made for 
each country chip, or in binaries that check themselves for tampering 
by secure crc, md5sum or similar methods.  If the modules crc changes, 
it must do an instant disable of the transmitter functions and exit or 
crash, thereby precluding any 'hot rodding' of the chipset.

So basicly, you can accept it with the wrappers Intel provides, or linux 
will not have access to the use of these devices, any of them that fit 
in the category of "software radios".  Intel et all has NO choice in 
the matter in this country by FCC decree, and I believe its copycatted 
by the Canadien DOC by treaty.  Other locales may change the rules 
slightly and often do, hence the requirement for manufacture of the 
software radio, one thats totally controlled by the software issued for 
that locale's use.

The fact that they are furnishing a wrapper, somewhat in the ndiswrapper 
style, says that Intel would like a piece of this market, but with the 
choice you are giving them with this arbitrary statement, they have no 
choice but to quietly fold up their tents and go home.  You are asking 
Intel to break the laws designed to enforce the use of the 802-11 bands 
in a legal manner.

So you might want to rethink your objections.  I agree that it should 
never become a piece of the kernel because it can't be audited, nor 
even dissed without a DMCA prosecution, but we've been using nvidia's 
stuff in modular fashion for quite some time, usually with decent 
results.  Its up to the user to install it of course, but thats 
precisely the same scenario here with the Intel code.  Intel will have 
to put it someplace where the *user* can download it, meaning a server 
setup someplace as opposed to handing the kernel developers one copy, 
but thats the breaks as we've chosen to do it.  Intel will also be 
expected to supply a method of fileing bugs in case it doesn't work.  A 
publicly postable list that is actually supported for any and all bug 
claims posted.  Its an expense for intel of course but thats their 
price of having a dog in this fight.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
