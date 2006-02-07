Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWBGS0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWBGS0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWBGS0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:26:18 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:60355 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964832AbWBGS0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:26:18 -0500
Message-ID: <43E8E612.5020402@cfl.rr.com>
Date: Tue, 07 Feb 2006 13:25:22 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>,
       alex-lists-linux-kernel@yuriev.com, linux-kernel@vger.kernel.org
Subject: Re: non-fakeraid controllers
References: <20060207015126.GA12236@s2.yuriev.com> <43E85337.1090001@aitel.hist.no> <43E8C088.1040206@cfl.rr.com> <20060207173927.GA16831@animx.eu.org>
In-Reply-To: <20060207173927.GA16831@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2006 18:27:14.0298 (UTC) FILETIME=[1E1F65A0:01C62C14]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14253.000
X-TM-AS-Result: No--9.350000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> I've been wondering about dmraid.  I considered buying an adaptec sata raid
> (hardware).  One of the drawbacks on hardware raid is the format isn't
> compatible with any other card (or rather manufacturer).  So the question
> is, has anyone written anything that can detect and activate disks from a
> hardware raid controller when they are placed on a controller w/o any raid?
>
> basically what I mean is, 3 disks, raid5 was in a system with hardware raid. 
> the raid card blows up and cannot get another one so to get the data back,
> place disks in another machine or on a standard controller and use software
> raid or whatever to recover the data.

Yes, that is one of the problems with hardware raid controllers.  If you 
can figure out the controller's metadata format, possibly by asking 
adaptec, or reverse engineering, then patching dmraid to understand that 
format ( it already understands several used by fakeraid controllers ) 
should be rather easy. 


