Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277547AbRJESvV>; Fri, 5 Oct 2001 14:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277548AbRJESvH>; Fri, 5 Oct 2001 14:51:07 -0400
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:60843 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id <S277547AbRJESur>; Fri, 5 Oct 2001 14:50:47 -0400
Date: Wed, 3 Oct 2001 13:55:59 +0200
From: Christof Efkemann <chref@tzi.de>
To: David Weinehall <tao@acc.umu.se>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830 support for agpgart
Message-Id: <20011003135559.1b11f0c4.chref@tzi.de>
In-Reply-To: <20011003045257.Q7800@khan.acc.umu.se>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de>
	<1001988137.2780.53.camel@phantasy>
	<20011002151051.488306ee.efkemann@uni-bremen.de>
	<1002066345.1003.66.camel@phantasy>
	<20011003021658.O7800@khan.acc.umu.se>
	<1002075650.1237.2.camel@phantasy>
	<20011003045257.Q7800@khan.acc.umu.se>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001 04:52:57 +0200
David Weinehall <tao@acc.umu.se> wrote:

> On Tue, Oct 02, 2001 at 10:20:43PM -0400, Robert Love wrote:
> > On Tue, 2001-10-02 at 20:16, David Weinehall wrote:
> > > If the only differences between the different cards are the nr of
> > > aperture-sizes and the status-register settings, why not have a struct
> > > which contains all the valid cards, and use a scan-routine?!

There is already such a struct, agp_bridge_info, and a scan-routine,
agp_lookup_host_bridge.  These values could probably be added easily.
Although it would then be necessary for the other chipsets, too.

> Afaik, speed is not really an issue (it's not like you're going to
> notice a difference anyway, even if you had a struct with 100 different
> adapters in it.) As for reapproaching the size of the current
> implementation, the difference is that you get one single function that
> you don't have to change. You just add one single line to the struct
> for each adapter.

Even if it was slower it wouldn't really matter, as this is executed only
once during initialization.

> > There are only 3 possibilities right now (i830, i840, and everything
> > else).

And don't forget the i850 ;-)

-- 
Regards,
Christof Efkemann
