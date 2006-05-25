Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWEYWhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWEYWhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWEYWhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:37:31 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:15838 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030492AbWEYWhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:37:31 -0400
Date: Thu, 25 May 2006 13:28:38 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Andrew Morton <akpm@osdl.org>
cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
In-Reply-To: <20060525150149.666c8476.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0605251322480.1828@dlang.diginsite.com>
References: <348469535.17438@ustc.edu.cn><20060525084415.3a23e466.akpm@osdl.
 org><Pine.LNX.4.63.0605251240160.1814@dlang.diginsite.com>
 <20060525150149.666c8476.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the developers of that program want to squeeze the last 5% out of it
> then sure, I'd expect them to use such OS-provided I/O scheduling
> facilities.  Database developers do that sort of thing all the time.
>
> We have an application which knows what it's doing sending IO requests to
> the kernel which must then try to reverse engineer what the application is
> doing via this rather inappropriate communication channel.
>
> Is that dumb, or what?
>
> Given that the application already knows what it's doing, it's in a much
> better position to issue the anticipatory IO requests than is the kernel.

if a program is trying to squeeze every last bit of performance out of a 
system then you are right, it should run on the bare hardware. however 
in reality many people are willing to sacrafice a little performance for 
maintainability, and portability.

if Adaptive read-ahead was only useful for Postgres (and had a negative 
effect on everything else, even if it's just the added complication in the 
kernel) then I would agree that it should be in Postgres, not in the 
kernel. but I don't believe that this is the case, this patch series helps 
in a large number of workloads (including 'cp' according to some other 
posters), postgres was just used as the example in this subthread.

gnome startup has some serious read-ahead issues from what I've heard, 
should it include an I/O scheduler as well (after all it knows what it's 
going to be doing, why should the kernel have to reverse-enginer it)

David Lang

