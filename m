Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285459AbRLNTBD>; Fri, 14 Dec 2001 14:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285460AbRLNTAq>; Fri, 14 Dec 2001 14:00:46 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:63130
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S285459AbRLNTA0>; Fri, 14 Dec 2001 14:00:26 -0500
Date: Fri, 14 Dec 2001 13:55:45 -0500
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, Johan Ekenberg <johan@ekenberg.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <3888420000.1008356144@tiny>
In-Reply-To: <20011214193217.H2431@athlon.random>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE>
 <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny>
 <3C1A3652.52B989E4@zip.com.au> <3845670000.1008352380@tiny>
 <20011214193217.H2431@athlon.random>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, December 14, 2001 07:32:17 PM +0100 Andrea Arcangeli
<andrea@suse.de> wrote:

> On Fri, Dec 14, 2001 at 12:53:00PM -0500, Chris Mason wrote:
>> I'll try this, and also add kinoded so we can avoid using keventd.  I'm
>> wary
> 
> using keventd for that doesn't look too bad to me. Just like we do with
> the dirty inode flushing. keventd doesn't do anything 99.9% of the time,
> so it sounds a bit wasteful to add yet another daemon that will remain
> idle 99% of the time too... :)

I think Andrew's idea was to avoid using it for inode flushing as well.
These are very time consuming tasks (especially if the journal is involved),
making keventd less repsonive to the short tasks it was intended to run.

-chris


