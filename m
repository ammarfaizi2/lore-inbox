Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267952AbRGVKal>; Sun, 22 Jul 2001 06:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267953AbRGVKab>; Sun, 22 Jul 2001 06:30:31 -0400
Received: from unthought.net ([212.97.129.24]:2206 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S267952AbRGVKaP>;
	Sun, 22 Jul 2001 06:30:15 -0400
Date: Sun, 22 Jul 2001 12:29:58 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Jimmie Mayfield <mayfield+usenet@sackheads.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting disk throughput performance problem
Message-ID: <20010722122958.C24136@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Jimmie Mayfield <mayfield+usenet@sackheads.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010721233313.A15232@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010721233313.A15232@sackheads.org>; from mayfield+usenet@sackheads.org on Sat, Jul 21, 2001 at 11:33:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 11:33:13PM -0400, Jimmie Mayfield wrote:
> Hi.  I'm running into some disk throughput issues that I can't explain.
> Hopefully someone reading this can offer an explanation.
> 
> One of my machines is running 2.4.5 and has 2 hard drives: a 7200 rpm
> ATA100 Maxtor and a 5400 rpm ATA33 IBM.  Each drive is a master on its own
> controller (AMI CMD649 as found on the IWill KT266-R).  Both drives contain
> reiserfs 3.6x filesystems.  
> 
> By all local benchmarks, the 7200 rpm drive is the faster drive.  But this 
> doesn't seem to be the case for large files originating from remote clients.  
> Witness:
....
> So I tried the test locally:  with the file stored on the 5400rpm drive, 
> scp it to localhost and write it to the 7200rpm drive.  Results were a little 
> below 10MB/sec (CPU near 100% presumably due to encrypting/decrypting on 
> the fly).
> 
> Any ideas why the 7200rpm drive performs so poorly for remote clients but 
> performs wonderfully well when those same operations are performed locally?

This is a wild guess:

Try cat /proc/interrupts

Would the 7200 rpm drive controller happen to share an IRQ with your NIC ?

If so, something is horribly wrong since that shouldn't give that kind of
performance penalty.  But it's my best guess   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
