Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVEEQOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVEEQOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVEEQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:14:00 -0400
Received: from 12-210-11-163.client.insightBB.com ([12.210.11.163]:33540 "HELO
	thor") by vger.kernel.org with SMTP id S262138AbVEEQN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:13:58 -0400
Date: Thu, 5 May 2005 12:12:50 -0400
From: "J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@thor.tetracon-eng.net
To: Deepak <deepakgaur@fastmail.fm>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real Time Signals In Powerpc Linux
In-Reply-To: <1115290744.30022.233426961@webmail.messagingengine.com>
Message-ID: <Pine.SGI.4.60.0505051208190.2617@thor.tetracon-eng.net>
References: <1115290744.30022.233426961@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


See linux/include/asm-xxx/signal.h in your kernel tree, where xxx is the 
specific arch you are interested in.

You will see definitions for a series of  _NSIG macros.  These define the 
number of available signals and the byte size of the signal mask data 
type.  The stuff at the bottom is educational as well.  You can then 
follow those defines into other header files as needed.

Happy hacking,

J. Scott Kasten
Email: jscottkasten AT yahoo DOT com

On Thu, 5 May 2005, Deepak wrote:

>
> I am working on a linux (v 2.4.20) based powerpc(8260) board. During
> development of an application program I planned to use real time
> signals(SIGRTMIN to SIGRTMAX) for interprocess communication. On giving
> the command 'kill -l' on the terminal window of ppc linux  it displayed
> only 32 signals while giving the same command on an Intel based Linux PC
> (same kernel version) showed all 64 signals.
>
> Anyone having idea whether these signals are present in powerpc Linux
> kernal v 2.4.20 ?
>
> Deepak Gaur
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
