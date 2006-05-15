Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWEOSPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWEOSPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEOSPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:15:17 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:17092 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965025AbWEOSPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:15:15 -0400
Message-ID: <4468C530.6080409@garzik.org>
Date: Mon, 15 May 2006 14:15:12 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org>
In-Reply-To: <20060515101831.0e38d131.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I'd be a little concerned with that merge plan at this time - we have a lot
> of sata bug reports banked up and afaict a pretty low fixup rate.  Then
> again, these patches might fix some of those bugs...
> 
> I guess if we can get it all in early (which is only a couple of weeks
> away!) and you and Tejun will have time set aside to work on problems then
> OK.  But....


As you can see from the list just sent, the improved error handling will 
give libata much greater ability to diagnose "controller is being weird" 
type situations, which is a lot of what the relevant bug reports need.

After reviewing those bug reports, I see a couple oopses -- caused by 
BUG()-style code, and fixed in this update -- and one data corruption 
which persists on Sil 311x on rare motherboards.  The rest are either 
addressed with the improved error handling, or are ATAPI + VIA AFAICS.

	Jeff


