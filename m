Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVDXIic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVDXIic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 04:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVDXIic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 04:38:32 -0400
Received: from colo.khms.westfalen.de ([213.239.196.208]:2195 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S262290AbVDXIiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 04:38:16 -0400
Date: 24 Apr 2005 10:00:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <9VVxJ6aHw-B@khms.westfalen.de>
In-Reply-To: <20050423174227.51360d63.pj@sgi.com>
Subject: Re: more git updates..
X-Mailer: CrossPoint v3.12d.kh15 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <d3dvps$347$1@terminus.zytor.com> <9VF1rZLXw-B@khms.westfalen.de> <9VF1rZLXw-B@khms.westfalen.de> <20050423174227.51360d63.pj@sgi.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj@sgi.com (Paul Jackson)  wrote on 23.04.05 in <20050423174227.51360d63.pj@sgi.com>:

> > It's an unavoidable
> > result of using less bits than the original data has.
>
> Even _not_ using a hash will have collisions - copy different globs of
> data around enough, and sooner or later, two globs that started out
> different will end up the same, due to errors in our computers.  Even
> ECC on all the buses, channels, and memory will just reduce this chance.

Umm, the whole point of using a digest for the name is to catch these  
things as they happen. So if you'd use the whole original bit sequence as  
a name, you'd need to have exactly the same bit errors in the data, in the  
name, and in the reference to the object, to miss nopticing the problem  
early. And it *still* isn't a collision - the data behind name X is  
exactly X, always, or it's easily recognizable as broken.

Whereas a hash collision means that both X and Y should be behind name Z.  
Both are *correct* behind name Z.

Entirely different situations.

> There is no mathematical perfection obtainable here.  Deal with it.

Actually, there is, and your non-hashed name system achieves it.

> If something is likely to happen less than once in a billion years,
> then for all practical purposes, it won't happen.

If that was a truely random thing, then you might have been right. But it  
isn't. All possible blobs to a given digest are NOT equally probably (or  
of a probability only depending on their size).

We really, really don't know how likely a collision is for the data we  
want to store there - just for truely random data.

MfG Kai
