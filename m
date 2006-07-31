Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWGaPSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWGaPSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWGaPSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:18:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4696 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932426AbWGaPSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:18:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CqMpr3NMWLp06j6lLpuUnyqQvNcR4m9hn2Uc1jesxV8up3D8BzH8WEWe9D74Ijzu6sGhKI7zFNvNlctVfNc4UHTZvI3Sz8U+EnBBLbJBb7vu/DVgT7jM74StAaIUVQbfSWaVKhaVC1GePce4xFgqiR6iG1uADefQJoHg25WYTrY=
Message-ID: <41840b750607310818j7ab2dcddpcb7a14b9a8f10871@mail.gmail.com>
Date: Mon, 31 Jul 2006 18:18:12 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: linux-thinkpad@linux-thinkpad.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ltp] Re: Generic battery interface
In-Reply-To: <20060731113735.GA22081@creature.apm.etc.tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	 <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	 <20060731113735.GA22081@creature.apm.etc.tu-bs.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Michael Olbrich <michael.olbrich@gmx.net> wrote:
> On Sun, Jul 30, 2006 at 09:37:23PM +0300, Shem Multinymous wrote:
> >
> > Comments?
>
> Hmmm, that looks good for most cases. But how would you handle
> starting/stoping laoding/draining the battery?
> That usually results in values jumping from/to 0. A gui would want to
> show such a change immediately while otherwise keeping a slow update
> rate. Maybe some kind of threshhold parameter? "send an input-ready
> immediatelly if the value changes by more than x%".

Changes by more than x% compared to what?

The value at the time of the ioctl()? This might completely miss a
change that happened between the previous read() and the ioctl().

The value at the time of the last read()? Then the kernel
driver+infrastructure will need to keep track of the latest readout
done by each app. That's pretty heavy.

So what semantics make sense?

  Shem
