Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbUKRGgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbUKRGgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbUKRGgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:36:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:22444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262621AbUKRGgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:36:48 -0500
Date: Wed, 17 Nov 2004 22:36:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: [ACPI] Re: system slow since ~ 2.6.7
Message-Id: <20041117223633.66993eda.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0411180722390.3577@poirot.grange>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
	<Pine.LNX.4.60.0411180722390.3577@poirot.grange>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(added linux-acpi)

Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
>
> On Thu, 18 Nov 2004, Guennadi Liakhovetski wrote:
> 
> > I've been running until now 2.6.3 without problem. I had a test 2.6.7 
> > kernel with reiserfs debugging enabled, and indeed it is running slow. Now 
> > I compiled 2.6.9 without reiserfs debugging, but it is still slow... In 
> 
> Indeed, booting with "acpi=off" brings the system back to normal under 
> 2.6.9. I'll try to see if I can norrow it down (after Saturday - I'm away 
> for 2 days now), but ideas are welcome.
> 

I guess a kernel profile would be useful.

- Add "profile=1" to the kernel boot command line
- Run some workload
- In another xterm, do:

	readprofile -r
	sleep 10
	readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40

  (make sure that you're using the correct System.map for the
  currently-running kernel).

