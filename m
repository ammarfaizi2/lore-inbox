Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbULaU1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbULaU1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbULaU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 15:27:09 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:50147 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262153AbULaU1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 15:27:02 -0500
Subject: Re: Queues when accessing disks
From: "M. Edward Borasky" <znmeb@cesmail.net>
Reply-To: znmeb@cesmail.net
To: Felipe Erias <charles.swann@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <169c13c404123019322a766f64@mail.gmail.com>
References: <169c13c404123019322a766f64@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 12:26:44 -0800
Message-Id: <1104524814.5185.28.camel@DreamGate>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 04:32 +0100, Felipe Erias wrote:
> Hi,
> 
> I'm trying to apply queuing theory to the study of the GNU/Linux kernel.
> Right now, I'm focusing in the queue of processes that appears when they
> try to access an I/O device (specifically, an IDE HD). When they want to
> read data, it behaves as a usual queue: several clients (processes) that
> require attention from a server (disk / driver / ...). The case when they want
> to write data is a bit more tricky, because of the cache buffers used by the OS,
> and maybe could be modelized by a network of queues. Both cases are
> interesting for my work, but I'll take the reading one first, just
> because it seems
> a bit more simple 'a priori'.
> 
> To modelize the queue, I need to get some information:
>  - what processes claim attention from the disk
>  - when they do it
>  - when they begin to be served
>  - when they finish being served
> 
> To get all this information, maybe I could hack my kernel a bit to write
> a line to a log on every access to the HD, or account the IRQs from
> the IDE channels... I also have the feeling that this queuing problem could
> dissappear o became more hidden if DMA were enabled.
> 
> To be true, I'm a bit lost and that's why I ask for your help.
> 
> Yours sincerely,
> 
>   Felipe Erias

I have a similar goal -- building an operational queueing model of a
running Linux system. At this point, though, I'm not really trying to do
per-process work, just model the system overall, including processors,
I/O and virtual memory. As I noted in a recent posting, I'm currently
blocked by the incorrect statistics gathered by a 2.4 kernel in
"/proc/partitions". You can compute the throughputs, but not the average
wait and service times, or the utilizations, which depend on the service
times.

I'm rather strongly considering establishing a mailing list just devoted
to this topic -- queuing models of Linux kernels based on statistics the
kernel collects. If such a list already exists, please let me know -- I
don't want to re-invent any wheels, but there *is* a wheel I do want to
invent! Please e-mail me off-list if you know of such a list or would
join in if I create it.

Thanks,

Ed Borasky
http://www.borasky-research.net/



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

