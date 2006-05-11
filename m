Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWEKKek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWEKKek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWEKKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 06:34:40 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:9230 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1030207AbWEKKej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 06:34:39 -0400
Message-ID: <4463133A.8060806@argo.co.il>
Date: Thu, 11 May 2006 13:34:34 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org> <20060509071640.GA4150@ucw.cz> <200605102209.05004.ak@suse.de> <20060510203015.GA13949@elf.ucw.cz>
In-Reply-To: <20060510203015.GA13949@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2006 10:34:36.0962 (UTC) FILETIME=[80401020:01C674E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Really? If someone does 
>
> 	if (something)
> 		clearsegment(seg)
> 	somethingelse();
>
> ... he'll get very confusing behaviour instead of compile error. 
>
> Okay, that's weaker argument than expected...
>
> Also clearsegment(x) clearsegment(y); will compile when it should not.
>
> Also clearsegment(i++) will behave strangely. So perhaps 
>
> #define clearsegment(seg) do { seg; } while (0)
>   

static inline void clearsegment(int seg) {}

?

-- 
error compiling committee.c: too many arguments to function

