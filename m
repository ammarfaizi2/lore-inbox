Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279304AbRJWHRm>; Tue, 23 Oct 2001 03:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRJWHRc>; Tue, 23 Oct 2001 03:17:32 -0400
Received: from bbmail1-out.unisys.com ([192.63.108.40]:45017 "EHLO
	bbmail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S279304AbRJWHRT> convert rfc822-to-8bit; Tue, 23 Oct 2001 03:17:19 -0400
Message-ID: <DD0DC14935B1D211981A00105A1B28DB033ED3E2@NL-ASD-EXCH-1>
From: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Case where VM of 2.4.13pre2aa falls apart
Date: Tue, 23 Oct 2001 03:17:41 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 19, 2001 at 10:47:21PM +0000, José Luis Domingo López wrote: 
> > On Friday, 19 October 2001, at 02:39:00 -0500, 
> > Leeuw van der, Tim wrote: 
> > 
> > > Hello, 
> > > 
> > > I've observed a case where the VM of 2.4.13pre2aa totally falls apart.
I 
> > > know it's not the latest of Andrea's VM tweaks, but I didn't yet get a

> > > chance to compile&reboot into a later version. I've noticed a similar 
> > > breakdown in one of the first pre-release kernels with the Andrea VM,
btw. 
> > > [...description of problem apparently related to Mozilla ...] 
> > > 
> > Maybe what happens here doesn't have anything in common with what you 
> > experienced, but a couple of days ago I suffered a full X server crash
due 
> > to a _big_ memory leak with Mozilla in one specific web page. 
> > 
> > Linux kernel 2.4.12, Mozilla 0.9.5, and X 4.1.0. Open 
> > www.securityfocus.org with Mozilla. For a couple of minutes, it seems
that 
> > all is going on nicely. Afterwards, and without any kind of user 
> > interaction with Mozilla, both mozilla and X processes start increasing 
> > their sizes, slowly, but steadily. 
> 
> 
> It certainly makes sense it's the userspace that has a leak and so the 
> system will start to swap and slowdown compared to the condition when 
> lots of free memory was available. 
> 
> 

It doesn't seem likely to me, as the total size of Mozilla was about 20Mb or
22Mb then, swap + RSS. I've gotten better performance with Netscape
exploding to +100Mb.

I've actually observed more weird slowdowns. The 'morning after' syndrome
I've described previously and lengthily doesn't always occur, there are
plenty of mornings where it actually picks up with good performance.
But the other day I upgraded again with apt-get dist-upgrade and dpkg hardly
managed to make any progress at all, with very low CPU useage for dpkg and
the system overal and (iirc) spinning disks.
General overal performance wasn't really hampered and starting up a
kernel-compile seemed to slightly improve the speed of dpkg.

Of course, this can all be coincidence, and it probably depends on many
factors. It could even be something very specific in a coupe of the scripts
that dpkg was running. However, it was highly uncharacteristic for dpkg and
apt-get upgrade. (dpkg is quite a memory and CPU hog btw when upgrading
packages).

As if the system sometimes penalizes certain processes, and sometimes picks
the wrong one. Is there anything in the kernel to penalize processes in some
way, based on process-behaviour?

This was still running 2.4.13pre2aa btw, I hadn't yet booted into pre3aa.
Uptime was over 4 days. I don't know if this uptime makes a difference?

I'm sorry for having so many vague descriptions and so little time to
experiment and collect data!


--Tim


> Andrea 
> - 
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in

> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at <http://vger.kernel.org/majordomo-info.html> 
> Please read the FAQ at <http://www.tux.org/lkml/> 
> 
> 
>   _____  


