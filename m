Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289619AbSA2L55>; Tue, 29 Jan 2002 06:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289532AbSA2L4l>; Tue, 29 Jan 2002 06:56:41 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:41988 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289516AbSA2LzE>; Tue, 29 Jan 2002 06:55:04 -0500
Message-ID: <3C568D6D.ACDEA36C@aitel.hist.no>
Date: Tue, 29 Jan 2002 12:54:21 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-dj6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
		<87lmehft5b.fsf@fadata.bg> <E16VU2h-00009Y-00@starship.berlin> <87g04pfr8y.fsf@fadata.bg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov wrote:
> 
> >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
[...]
> Daniel> It's only touching the ptes on tables that are actually used, so if a parent
> Daniel> with a massive amount of mapped memory forks a child that only instantiates
> Daniel> a small portion of it (common situation) then the saving is pretty big.
> 
> Umm, all the ptes af the parent ought to be made COW, no ?

Sure. But quite a few of them may be COW already, if the parent 
itself is a result of some earlier fork.

Helge Hafting
