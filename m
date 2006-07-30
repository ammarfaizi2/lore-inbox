Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWG3PV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWG3PV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWG3PVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:21:25 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:43788 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932336AbWG3PVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:21:25 -0400
Message-ID: <44CCCE72.8030808@argo.co.il>
Date: Sun, 30 Jul 2006 18:21:22 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <1154271283.2941.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1154271283.2941.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2006 15:21:23.0172 (UTC) FILETIME=[D0FF5A40:01C6B3EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> > > So 2 questions are:
> > > 1) howto FP in kernel
> > >
> > kernel_fpu_begin();
> > c = d * 3.14;
> > kernel_fpu_end();
> >
>
> unfortunately this only works for MMX not for real fpu (due to exception
> handling uglies)
>

Perhaps there should be a comment to that effect?  Neither the code nor 
Documentation/preemt-locking (which mentions the fpu) says anything 
about this little fact.

It's also broken for x86-64, which uses sse for floating point, not the 
x87 fpu.

-- 
error compiling committee.c: too many arguments to function

