Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265150AbSKEX6O>; Tue, 5 Nov 2002 18:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265162AbSKEX5T>; Tue, 5 Nov 2002 18:57:19 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33279 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265380AbSKEX4R>;
	Tue, 5 Nov 2002 18:56:17 -0500
Date: Tue, 05 Nov 2002 16:57:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: bert hubert <ahu@ds9a.nl>
cc: Peter Chubb <peter@chubb.wattle.id.au>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <27920000.1036544267@flay>
In-Reply-To: <20021105231649.GA14511@outpost.ds9a.nl>
References: <15816.19206.959160.739312@wombat.chubb.wattle.id.au> <26610000.1036541181@flay> <20021105231649.GA14511@outpost.ds9a.nl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The locking of walking the tasklist seems non-trivial, but we may well
>> end up with something like that. By the time you finish, it looks more
>> like a /dev device thing than /proc (which I'm fine with), and looks
> 
> Can people just oprofile this instead of guessing? Opening a file is not
> very expensive anymore, so if ps is noticeably slow, it must be something
> else.
> 
> 'To measure is to know'

Errm... we have profiled it. Look at the subject line ... this started
off as a dcache_rcu discussion. The dcache lookup ain't cheap, for 
starters, but that's not really the problem ... it's O(number of tasks),
which sucks.

M.

