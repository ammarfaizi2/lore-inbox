Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJYPok>; Thu, 25 Oct 2001 11:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJYPob>; Thu, 25 Oct 2001 11:44:31 -0400
Received: from geos.coastside.net ([207.213.212.4]:3003 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S275097AbRJYPoX>; Thu, 25 Oct 2001 11:44:23 -0400
Mime-Version: 1.0
Message-Id: <p05100304b7fde3463344@[207.213.214.37]>
In-Reply-To: <9r9asg$7jr$1@ncc1701.cistron.net>
In-Reply-To: <9r8icv$ukh$1@ncc1701.cistron.net> <20011025082001.B764@hq2>
 <9r9asg$7jr$1@ncc1701.cistron.net>
Date: Thu, 25 Oct 2001 08:44:09 -0700
To: "Rob Turk" <r.turk@chello.nl>, linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:22 PM +0200 10/25/01, Rob Turk wrote:
>  > I'm failing  to imagine a good case for suspending a system that has a
>>  tape drive on it.
>>
>
>Well, maybe the tape example wasn't all that good. The state information
>(wide/sync negotiation) still needs to be retained for all SCSI 
>devices though.

Any driver that uses SCSI bus reset for last-resort error recovery 
(and I think it's pretty typical) needs to be able to renegotiate the 
connection. Maybe even after a SCSI device reset; I don't recall. So 
initiating that negotiation as part of (or after) resume doesn't seem 
all that burdensome.

You need that anyway for "deep sleep" that powers down devices completely.
-- 
/Jonathan Lundell.
