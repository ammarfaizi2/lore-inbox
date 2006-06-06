Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWFFKMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWFFKMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWFFKMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:12:08 -0400
Received: from mailgw4.ericsson.se ([193.180.251.62]:49121 "EHLO
	mailgw4.ericsson.se") by vger.kernel.org with ESMTP id S932148AbWFFKMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:12:07 -0400
Message-ID: <448554F3.1000308@ericsson.com>
Date: Tue, 06 Jun 2006 12:12:03 +0200
From: Preben Traerup <Preben.Trarup@ericsson.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com> <20060530145658.GC6536@in.ibm.com> <20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com> <20060531154322.GA8475@in.ibm.com> <20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com> <20060601151605.GA7380@in.ibm.com> <20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com> <44800E1A.1080306@ericsson.com> <20060602145626.GB29610@in.ibm.com>
In-Reply-To: <20060602145626.GB29610@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2006 10:12:04.0995 (UTC) FILETIME=[A927C530:01C68951]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

>I think if we decide to implement something which allows other policies 
>to co-exist with crash_kexec() then it should be more generic then a
>single function pointer.
>
>Thanks
>Vivek
>
>  
>
A single function pointer function is suggested because it is the 
simpliest compromise
I can thing of which should be able to satisfy all.

The simpliest policy I can think of is
-flip a bit on _dedicated_ hardware (crash notifier)
-launch capture kernel (existing kexec)

Nothing prevents you from implementing multiple policies to be 
executed/selected among from
whatever is called by the single pointer function.


My key point is:
The complexity in my suggestion is a low as it can get, thus reliability of
kexec (hopefully) is unaffected
If crash notifiers is implemented by a complex "management system", I 
might loose
reliability of kexec because of something I basically do not need.

Or to put it in other words, I you need to implement anything complex 
for managing your policies,
you should add it yourself and you yourself is the only one being 
affected by increased complexibility.

./Preben
