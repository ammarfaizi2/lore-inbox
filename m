Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbTBLQAD>; Wed, 12 Feb 2003 11:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbTBLQAD>; Wed, 12 Feb 2003 11:00:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18442 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267552AbTBLQAC>;
	Wed, 12 Feb 2003 11:00:02 -0500
Message-ID: <3E4A71B2.8040007@pobox.com>
Date: Wed, 12 Feb 2003 11:09:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 cheerleading...
References: <3E4A6DBD.8050004@pobox.com> <1045065615.22294.11.camel@plars>
In-Reply-To: <1045065615.22294.11.camel@plars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> On Wed, 2003-02-12 at 09:52, Jeff Garzik wrote:
> 
>>Just to counteract all the 2.5.60 bug reports...
>>
>>After the akpm wave of compile fixes, I booted 2.5.60-BK on my Wal-Mart 
>>PC [via epia], and ran LTP on it, while also stressing it using 
>>fsx-linux in another window.  The LTP run showed a few minor failures, 
>>but overall 2.5.60-BK is surviving just fine, and with no corruption.
> 
> Can you send me your list of failures and version of LTP?  I'd like to
> make sure they match up with the known list of problems.


Version is CVS-latest, checked out last night.

Some of the failures were obvious:  kernel module syscalls were failing, 
as I would expect them to if they had not been updated for 2.5.x module 
support.  There were also a couple signal-related things, IIRC. 
Unexpected failures included some file locking test failures.

Anyway, don't worry... you will be getting more concrete info soon :)  I 
am tracking down right now why the 2.5.x floppy driver ends all I/O 
requests with an error.  After that, I'll have output from a full LTP 
run for you :)

