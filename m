Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUBPLGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 06:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUBPLGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 06:06:39 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:35013 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263620AbUBPLGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 06:06:38 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Reserved pages not flagged on Compaq evo?
Date: Mon, 16 Feb 2004 19:16:16 +0800
User-Agent: KMail/1.5.4
Cc: Andrea Arcangeli <andrea@suse.de>
References: <87llnyggfm.fsf@larve.net> <20040204114113.GA1110@home.larve.net> <200402042024.47784.mhf@linuxmail.org>
In-Reply-To: <200402042024.47784.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161916.16508.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 February 2004 20:36, Michael Frank wrote:
> A 2.4.24 + swsusp 2.0 user reported a mce at the video base address
> of 0xa0000 when writing the kernel image to disk (thus reading there)
> on a Compaq evo1015v (Athlon XP 2000+)
> 
> NOMCE eliminates the mce but I am wondering about possible ill effects
> should other reserved pages be invalidly accessed.
>   
> It looks like these pages are not flagged reserved and therfore accessed. 
> 
> No other mce's have ever been reported.
> 
> What is the suggested approach to identify the root cause?

Has been verified as fixed after flagging video and BIOS pages as nosave and
by not accessing all nosave areas during suspend and resume. 
 
> Michael
> 
> 

