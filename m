Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVLSPGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVLSPGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVLSPGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:06:37 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:5935 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932144AbVLSPGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:06:36 -0500
In-Reply-To: <DADA32856852FC458E0F96B664A6F55E011E2311@kom-mailsrv1.kontron-modular.com>
References: <DADA32856852FC458E0F96B664A6F55E011E2311@kom-mailsrv1.kontron-modular.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <74737B51-64DC-445A-93E9-2AE6DFFCE736@kernel.crashing.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Submitting patches for Kontron-boards with Freescale processors
Date: Mon, 19 Dec 2005 09:06:40 -0600
To: Claus Gindhart <Claus.Gindhart@kontron.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 19, 2005, at 2:07 AM, Claus Gindhart wrote:

> Kumar,
>
> in our department we have Linux 2.6 kernel ports for Kontron  
> embedded computer boards with freescale processors 8245, 405, 8540,  
> 8541, 8347, 8270, ...
>
> We would like to start now to submit all these board supports to  
> the vanilla kernel.
>
> For the start we would select one of our common boards, e.g. the  
> one with 8540/8541 processor.
>
> My question is now:
> Should we try to provide a patch with all HW-features of the board  
> supported, or would it be better to start with a minimalistic  
> patch, and then add support for additional devices onboard (e.g.  
> IDE, RTC, SuperIO, ...) time by time ?
>
> Or would it be better to provide the full feature set of this board  
> at one time ?

First, I would recommend posting such queries to the linuxppc lists  
(linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org).

Second, I'm no longer at Freescale so please email me at this address.

Ok, now to your question.  In general if a given board port touch  
files in arch/ppc/platforms/* than all of that code should be in one  
patch.  If you are touching anything in drivers/* you need to  
separate out those patches and send them to the respective driver  
maintainers.  If you want to provide a more detailed list of changes  
for 8540/8541 I can provide better directions on how to submit patches.

What boot loader are you using for your boards?  I ask because for  
the 85xx and 83xx subarchitectures I'm trying to limit new board  
ports in arch/ppc as we try to transition to arch/powerpc.  However,  
this requires that the firmware provide a flatten device tree to the  
kernel.

Hopefully that gets you a sense and feel free to ask any other  
questions.

- kumar


