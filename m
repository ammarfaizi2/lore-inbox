Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUCaSut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUCaSut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:50:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:6846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262335AbUCaSur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:50:47 -0500
Date: Wed, 31 Mar 2004 10:50:39 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Powers-of-two - 7 for recv() length??
Message-Id: <20040331105039.74354503@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.53.0403311257390.12123@chaos>
References: <Pine.LNX.4.53.0403311128200.11700@chaos>
	<20040331091646.4b1e0e70@dell_ss3.pdx.osdl.net>
	<Pine.LNX.4.53.0403311257390.12123@chaos>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 13:02:03 -0500 (EST)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> On Wed, 31 Mar 2004, Stephen Hemminger wrote:
> 
> > What is the socket send/receive buffering, and the underlying network.
> > You need to look at the data flow with something like tcpdump and tcptrace.
> > If you get flow controlled or lots of other reasons, TCP will validly
> > send a small number of bytes (like 1) which will get things out of alignment.
> >
> 
> Hmmm. I get lots of truncated IP packets. See attached. I've tried
> to help by setting both RCV_BUF and SND_BUF to 1/2 megabytes. Nothing
> seems to work except sending only 1436 bytes at a time. That makes
> everything miserably slow. 1436 comes from (1500 - 64) 1500 being the
> ethernet packet length, 64 being the IP header length.
>

That is because you are running on the loopback interface that has an
MTU of 16K.  And tcpdump is being smart and only reading part of the
data.



> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 


-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
