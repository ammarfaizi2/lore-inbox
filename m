Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWGHSqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWGHSqE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWGHSqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:46:04 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:57864 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750854AbWGHSqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:46:02 -0400
Message-ID: <44AFFD61.1080407@argo.co.il>
Date: Sat, 08 Jul 2006 21:45:53 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
       Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <m364i8e42v.fsf@defiant.localdomain>
In-Reply-To: <m364i8e42v.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jul 2006 18:46:00.0614 (UTC) FILETIME=[C1D5D460:01C6A2BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
>
> Pavel Machek <pavel@ucw.cz> writes:
>
> > Why not? You use libextfs or how is it called to read the file from
> > the disk directly (read-only access), then you write it back using
> > regular calls.
> >
> > Of course, you can end up with "deleted" data being corrupted if
> > kernel reused the area before undelete, or while you were doing
> > undelete... but that's expected. They were _deleted_, right?
>
> What if the "undeleted" file contained /etc/shadow because someone
> was changing password at the time? :-)
>

As the undeleter already had read access to the raw device, /etc/shadow 
was already compromised.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

