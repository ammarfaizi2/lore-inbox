Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbQKADPc>; Tue, 31 Oct 2000 22:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbQKADPW>; Tue, 31 Oct 2000 22:15:22 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:19213 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131161AbQKADPO>; Tue, 31 Oct 2000 22:15:14 -0500
Date: Tue, 31 Oct 2000 21:15:06 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
Message-ID: <20001031211506.E1041@wire.cadcamlab.org>
In-Reply-To: <39FF0A71.FE05FAEB@gromco.com> <Pine.LNX.4.10.10010311018180.7083-100000@penguin.transmeta.com> <8tn5q9$iu5$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8tn5q9$iu5$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Oct 31, 2000 at 11:16:25AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[hpa]
> I was going to ask to what extent we genuinely need sorting, and if
> we might be better off trying to eliminate that need as much as
> possible.

We don't need sorting.  We need removing of duplicates.  The GNU make
sort function removes duplicates as a side effect, which is why we want
to use it.

As has been discussed, there are lots of ways to remove duplicates.
You can spawn a shell script, you can keep track of each "common" file
with a tristate make variable, you can play with deeply nested if
statements, and rumor has it you may be able to write a custom GNU make
function (though I have doubts, as I have tried this before and
couldn't get anything to work).

To Keith, Michael and me, the cleanest way to remove duplicates is
$(sort).  Since some object files must *not* be sorted, we came up with
a simple, readable way to declare that certain things had to come in a
certain order -- the idea being that most of the time it would not be
needed.  Linus disagrees that our solution is simple, readable or
otherwise desirable.  That's basically the whole issue in a nutshell.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
