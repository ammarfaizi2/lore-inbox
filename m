Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264004AbUCZKr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbUCZKr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:47:57 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:18705 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264004AbUCZKrz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:47:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Large memory application exhuasts buffers during write.
Date: Fri, 26 Mar 2004 12:47:10 +0200
X-Mailer: KMail [version 1.4]
References: <20040326012056.GB19152@lnx-holt>
In-Reply-To: <20040326012056.GB19152@lnx-holt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403261247.10807.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 March 2004 03:20, Robin Holt wrote:
> We have a large memory application which is being killed by the OOM
> killer.
>
> This is a 2.4 based kernel with many of the redhat patches applied.
> Before the application is started, there is approx 350GB of memory
> free according to top.  When the app starts, it mallocs a 300GB
> buffer, initializes it, does computations into it, and then starts
> to write it to a disk file.
>
> What we see happen is the first approx 30GBs gets written and then
> swap starts getting utilized.  Once swap has been heavily utilized,
> the OOM killer kicks in and kills the job.

How many swap do you have? What do you see in top?

> The application is a vendor provided app and probably cannot be
> modified.  Does anybody have any suggestion on possible changes
> to make to the kernel to eliminate or significantly reduce the
> likelihood that the job gets terminated.
-- 
vda
