Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSGRQKG>; Thu, 18 Jul 2002 12:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318146AbSGRQKG>; Thu, 18 Jul 2002 12:10:06 -0400
Received: from a208-141.dialup.iol.cz ([194.228.141.208]:16133 "EHLO devix")
	by vger.kernel.org with ESMTP id <S318141AbSGRQKF>;
	Thu, 18 Jul 2002 12:10:05 -0400
Date: Thu, 18 Jul 2002 17:44:56 +0200 (CEST)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 is not SMP friendly
In-Reply-To: <1026999905.9727.13.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0207181722080.535-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Yes I use smbfs.
Regarding my oops report, is there known
bug where waitqueue would be corrupted ? When I analyzed
it I found that invalid address 8bd4189c was loaded from
tasklist pointer in wait_queue_head_t (sched.c, __wake_up_common
line "p = curr->task").
The wakeup was called from get_new_inode and seems like
if list of tasks was not initialized of what :(

thanks, devik

On 18 Jul 2002, Alan Cox wrote:

> On Thu, 2002-07-18 at 11:51, devik wrote:
> > I someone here running 2.4.18 on PII SMP successfully ?
>
> PPro in my case but yes. 2.4.18 ought to be pretty solid except for some
> annoying bugs you'll only hit if you use smbfs.
>
>

