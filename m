Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272219AbTG2X2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272216AbTG2X2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:28:43 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:260 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S272219AbTG2X2m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:28:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bill Davidsen <davidsen@oddball.prodigy.com>
Reply-To: davidsen@tmr.com
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.6.0-test1 cryptoloop & aes
Date: Tue, 29 Jul 2003 19:28:39 -0400
User-Agent: KMail/1.4.1
References: <20030720005726.GA735@jolla> <20030720103852.A11298@pclin040.win.tue.nl>
In-Reply-To: <20030720103852.A11298@pclin040.win.tue.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307291928.39288.davidsen@oddball.prodigy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 July 2003 04:38 am, Andries Brouwer wrote:
> On Sat, Jul 19, 2003 at 05:57:26PM -0700, Hielke Christian Braun wrote:
> > Then i installed the losetup from util-linux-2.12pre.
>
> You need util-linux-2.12 or later.
>
> (try ftp://ftp.cwi.nl/pub/aeb/util-linux or so)
>
> Andries

Thank you, that's the missing part. I will say that in limited use I have used 
aes and twofish and they seem to work correctly. I copied a bunch of data 
there, checked it against the md5 contents file and all data was correct, did 
a bunch of renames, slinks, compiles, etc. unmounted and remounted a few 
times. So far so good, this isn't critical data, but I'm leaning that way for 
my laptop.

All this with 2.6.0-test1-ac2.

Now, for the bizarre test case, suppose I did three encrypted losetups, each 
using a different encryption. Then I made a raid-5 array of the three loop 
devices. created a filesystem on the md device, and ran on that. Forget the 
practicality, this is a test to see of the parts are robust, can I do it and 
will it work?

Now make two of those filesystems losetups of NBDs. Now I can recover if any 
one machine is missing, no one can recover the data without compromising at 
least two machines. again, forget practical, this is a test and maybe has 
application to the devout fundamentalist paranoid. If I was going to do it 
I'd loopback mount the md device, too ;-)
