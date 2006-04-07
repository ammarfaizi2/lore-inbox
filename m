Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWDGJPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWDGJPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDGJPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:15:35 -0400
Received: from mx1.suse.de ([195.135.220.2]:15528 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932393AbWDGJPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:15:35 -0400
From: Andreas Schwab <schwab@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: "Tony Luck" <tony.luck@gmail.com>, "Mike Hearn" <mike@plan99.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <4431A93A.2010702@plan99.net>
	<m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
	<44343C25.2000306@plan99.net>
	<12c511ca0604061633p2fb1796axd5acad8373532834@mail.gmail.com>
	<17462.6689.821815.412458@cse.unsw.edu.au>
X-Yow: Civilization is fun!  Anyway, it keeps me busy!!
Date: Fri, 07 Apr 2006 11:15:33 +0200
In-Reply-To: <17462.6689.821815.412458@cse.unsw.edu.au> (Neil Brown's message
	of "Fri, 7 Apr 2006 17:52:01 +1000")
Message-ID: <jeirplrbka.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> writes:

> On Thursday April 6, tony.luck@gmail.com wrote:
>> > > I have concerns about security policy ...
>> >
>> > I'm not sure I understand. Only if you run that program, and if you
>> > don't have access to the intermediate directory, how do you run it?
>> 
>> It leaks information about the parts of the pathname below the
>> directory that you otherwise would not be able to see.  E.g. if
>> I have $HOME/top-secret-projects/secret-code-name1/binary
>> where the top-secret-projects directory isn't readable by you,
>> then you may find out secret-code-name1 by reading the
>> /proc/{pid}/exedir symlink.
>
> But we already have /proc/{pid}/exe which is a symlink to the
> executable, thus exposing all the directory names already.

Neither of which should be readable by anyone but the owner of the
process, which is the one who was able to read the secret directory in the
first place.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
