Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293689AbSCFRPW>; Wed, 6 Mar 2002 12:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293708AbSCFRPN>; Wed, 6 Mar 2002 12:15:13 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:63978 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293697AbSCFRPF>; Wed, 6 Mar 2002 12:15:05 -0500
Date: Wed, 6 Mar 2002 11:15:02 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: J Sloan <joe@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recommendations about a 100/10 NIC
Message-ID: <20020306111502.D8107@asooo.flowerfire.com>
In-Reply-To: <3C82148E.E530824@wanadoo.es> <3C825A19.5070204@tmsusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C825A19.5070204@tmsusa.com>; from joe@tmsusa.com on Sun, Mar 03, 2002 at 09:15:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 09:15:05AM -0800, J Sloan wrote:
| In my humble experience with some hundreds
| of different Linux servers, the 3c905 seems the
| most trouble-free, and performs well.

Ah, I bet you didn't live through the truly atrocious 3Com drivers of
the past. ;)  The new 3Com stuff seems passable for desktops, but having
been bitten dozens of times, I'm about 4^4^4^4 times shy.

| The Intel adapter has potential driver issues,
| although they seem to be getting resolved.

Haven't had any issues at all with eepro100 or e100 under production
load for years.  Since Tulip went out of the mainstream (poor Digital)
the EtherExpress has been the most stable everywhere I've been.  I've
written too many scripts for 3Com boxes that grep dmesg for "fatal"
errors and unload/reload the 3com module.

| The e100 driver has the disadvantage of being
| unable to work with the mii-tool commands,

Yes, and the fact that it "can't" be compiled-in.

| but seems to work well otherwise - as long as
| you don't mind trying to puzzle out whether
| the card is conected at 10 or 100, full or half.

That's all logged (dmesg, etc), if not distinctly queryable.  Don't the
iANS tools allow this functionality, and more?

| The eepro100 driver works with mii-tool, but
| many have reported issues with the card dying
| under heavy use and needing to be reset. Many
| are using the eepro100 without problems - but
| the bottom line is that nobody is seeing these
| problems with the 3com cards.

Uhm, "nobody" is certainly not the proper word in this context.  We've
pulled many 3Com cards because of issues, including ARP deafness,
overruns, hangs, etc.  I have fully-saturated IDS systems running
eepro100 and e100 without issue, so heavy use may be necessary but is
not sufficient.

Oh, and six years of production on hundreds of EtherExpress NICs with
zero (0) issues.  Obviously, not everyone sees every bug, but the
preponderance of evidence I've seen in production environments puts the
EE way ahead of 3Com.  3Com for Windows desktops works just fine.

I'd like to try existing Tulip hardware though for another option.
Though 8139too seems to work well.

-- 
Ken.
brownfld@irridia.com

| 
| YMMV of course -
| 
| Joe
|  
| 
| janvapan wrote:
| 
| >What ethernet cards I should use for Linux 2.4?.
| >I am looking for a NIC based on stability and performance.
| >In short, Intel PRO/100 S Desktop Adapter(e100 driver) or
| >3Com 10/100 3C905C-TX-M(3c59x driver) ?
| >
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
