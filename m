Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285118AbRLQMRM>; Mon, 17 Dec 2001 07:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285099AbRLQMQw>; Mon, 17 Dec 2001 07:16:52 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:19464 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S285108AbRLQMQl>;
	Mon, 17 Dec 2001 07:16:41 -0500
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: [PATCH] kill(-1,sig)
Date: Mon, 17 Dec 2001 12:16:40 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9vknn8$e6g$1@ncc1701.cistron.net>
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl> <20011217013445.A30669@figure1.int.wirex.com> <01121712412100.02022@manta> <20011217115344.C14112@dev.sportingbet.com>
X-Trace: ncc1701.cistron.net 1008591400 14544 195.64.65.67 (17 Dec 2001 12:16:40 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011217115344.C14112@dev.sportingbet.com>,
Sean Hunter  <sean@dev.sportingbet.com> wrote:
>On Mon, Dec 17, 2001 at 12:41:21PM -0200, vda wrote:
>> Hmm. Looking at killall5 source I see
>> 
>> kill(-1, STOP);
>> I guess STOP will stop killall5 too? Not good indeed.
>> 
>Couldn't it just do:
>
>sigprocmask (SIG_BLOCK, &new, &savemask);
>... in other words, block signals, do the killing, then unblock?

You can't block SIGSTOP and SIGKILL

Mike.
-- 
Deadlock, n.:
        Deceased rastaman.

