Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135454AbRARO53>; Thu, 18 Jan 2001 09:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135661AbRARO5S>; Thu, 18 Jan 2001 09:57:18 -0500
Received: from Cantor.suse.de ([194.112.123.193]:19462 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135454AbRARO5O>;
	Thu, 18 Jan 2001 09:57:14 -0500
Date: Thu, 18 Jan 2001 15:57:11 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118155711.A25378@gruyere.muc.suse.de>
In-Reply-To: <3A660746.543226B@cup.hp.com> <Pine.LNX.4.30.0101181358010.823-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101181358010.823-100000@elte.hu>; from mingo@elte.hu on Thu, Jan 18, 2001 at 02:06:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 02:06:46PM +0100, Ingo Molnar wrote:
> 
> On Wed, 17 Jan 2001, Rick Jones wrote:
> 
> > i'd heard interesting generalities but no specifics. for instance,
> > when the send is small, does TCP wait exclusively for the app to
> > flush, or is there an "if all else fails" sort of timer running?
> 
> yes there is a per-socket timer for this. According to RFC 1122 a TCP
> stack 'MUST NOT' buffer app-sent TCP data indefinitely if the PSH bit
> cannot be explicitly set by a SEND operation. Was this a trick question?
> :-)

Are you sure? The retransmit timer is not necessarily started and I don't 
see any other timer in 2.2 or plain 2.4 that would do that that.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
