Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266332AbUBDLg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 06:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUBDLgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 06:36:02 -0500
Received: from gw-nl6.philips.com ([161.85.127.52]:16866 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S266325AbUBDLfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 06:35:21 -0500
Message-ID: <4020D9A5.2040109@basmevissen.nl>
Date: Wed, 04 Feb 2004 12:38:13 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@users.sourceforge.net
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Dittmer <j.dittmer@portrix.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net> <20040129114400.GA27702@thunk.org> <4020BA67.9020604@basmevissen.nl> <1075887812.2518.125.camel@laptop-linux>
In-Reply-To: <1075887812.2518.125.camel@laptop-linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> Hi.
> 
> Are you using a swap partition or swap file? If we're talking swap file,
> I would suspect suspend2. I haven't had a chance to look yet (preparing
> to move to Aussie), but Michael has told me there are problems with the
> swapfile support.
> 

You are reading everything, I beleave :-)
Nope, only a swap partition. I read swsusp ML too :-)

I really suspect the power failure (forgot to plug in the AC adapter :-) 
) was the "hard off" with the FS corruption.

> If you had a crash while using suspend and swap file support, I wouldn't
> be totally surprised to see an emergency sync causing this. That said,
> the code has a number of safety nets aimed at stopping us syncing while
> suspend is running, to avoid precisely this sort of corruption. If it
> was suspend, I'd expect your superblock to have been messed too. Did
> that happen?
> 

The superblock was fine. There was just a short file system check when 
booting again. I only noticed it a day later when the news reader didn't 
want to start anymore.

But thanks for thinking!

Regards,

Bas.


