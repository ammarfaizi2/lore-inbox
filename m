Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286194AbRLJIaG>; Mon, 10 Dec 2001 03:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286196AbRLJI34>; Mon, 10 Dec 2001 03:29:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15622 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286194AbRLJI3r>; Mon, 10 Dec 2001 03:29:47 -0500
Subject: Re: question on select:  How big can the empty buffer space be before select returns ready-to-write?
To: chris@wirex.com (Chris Wright)
Date: Mon, 10 Dec 2001 08:38:18 +0000 (GMT)
Cc: greearb@candelatech.com (Ben Greear),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20011209233349.C27109@figure1.int.wirex.com> from "Chris Wright" at Dec 09, 2001 11:33:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DLx4-0001Ds-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> * Ben Greear (greearb@candelatech.com) wrote:
> > For instance, it appears that select will return that a socket is
> > writable when there is, say 8k of buffer space in it.  However, if
> > I'm sending 32k UDP packets, this still causes me to drop packets
> > due to a lack of resources...
> 
> udp has a fixed 8k max payload. did you try breaking up your packets?

UDP has a 64K - headers max payload. 

