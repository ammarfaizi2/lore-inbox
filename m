Return-Path: <linux-kernel-owner+w=401wt.eu-S965353AbXAKKRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbXAKKRY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965359AbXAKKRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:17:24 -0500
Received: from mail.station1.mxsweep.com ([212.147.136.149]:2899 "EHLO
	blue.mxsweep.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965353AbXAKKRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:17:22 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 05:17:22 EST
Message-ID: <45A60C51.4050305@draigBrady.com>
Date: Thu, 11 Jan 2007 10:07:13 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Miklos Szeredi <miklos@szeredi.hu>,
       pavel@ucw.cz, mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx,
       bhalevy@panasas.com, arjan@infradead.org, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
References: <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz> <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz> <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu> <20070108112916.GB25857@elf.ucw.cz> <E1H3tAe-00052Q-00@dorka.pomaz.szeredi.hu> <1168359985.7817.4.camel@localhost.localdomain> <20070109195310.GA10572@janus>
In-Reply-To: <20070109195310.GA10572@janus>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mlf-Version: 5.0.1.8359
X-Mlf-UniqueId: o200701111013060078008
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
> On Tue, Jan 09, 2007 at 11:26:25AM -0500, Steven Rostedt wrote:
>> On Mon, 2007-01-08 at 13:00 +0100, Miklos Szeredi wrote:
>>
>>>> 50% probability of false positive on 4G files seems like very ugly
>>>> design problem to me.
>>> 4 billion files, each with more than one link is pretty far fetched.
>>> And anyway, filesystems can take steps to prevent collisions, as they
>>> do currently for 32bit st_ino, without serious difficulties
>>> apparently.
>> Maybe not 4 billion files, but you can get a large number of >1 linked
>> files, when you copy full directories with "cp -rl".
> 
> Yes but "cp -rl" is typically done by _developers_ and they tend to
> have a better understanding of this (uh, at least within linux context
> I hope so).

I'm not really following this thread, but that's wrong.
A lot of people use hardlinks to provide snapshot functionality.
I.E. the following can be used to efficiently make snapshots:

rsync /src/ /backup/today
cp -al /backup/today /backup/$Date

See also:

http://www.dirvish.org/
http://www.rsnapshot.org/
http://igmus.org/code/

> Also, just adding hard-links doesn't increase the number of inodes.

I don't think that was the point.

Pádraig.
