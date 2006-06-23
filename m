Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752052AbWFWVCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbWFWVCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbWFWVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:02:55 -0400
Received: from outbound-res.frontbridge.com ([63.161.60.49]:47954 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1752052AbWFWVCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:02:54 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Fri, 23 Jun 2006 15:07:12 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: Geode patches for 2.6.17
Message-ID: <20060623210712.GE13017@cosmic.amd.com>
References: <20060623170058.GA12819@cosmic.amd.com>
 <1151088069.4549.72.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1151088069.4549.72.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 23 Jun 2006 21:01:59.0945 (UTC)
 FILETIME=[44FAAF90:01C69708]
X-WSS-ID: 6882894D27K13541749-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/06 19:41 +0100, Alan Cox wrote:
> Ar Gwe, 2006-06-23 am 11:00 -0600, ysgrifennodd Jordan Crouse:
> >       Add a configuration option to avoid automatically probing VGA
> 
> Can you not do this automatically using the DMI data or PCI subvendor
> id ?

This option actually disables VGA probing kernel wide - it essentially 
skips all of video.S during boot, and then disallows any drivers that may
depend on that data (VGA console being the prime example).

While I am about 85% sure that probing the missing VGA/VESA registers will 
not cause any problems, the values read will be nonsense, and I wanted to 
avoid the possibility that any part of the code will blindly use the 
returned data without checking it. 

The option is triggered off of EMBEDDED, and I felt it would be buried 
deep enough to not cause heartburn to the casual user.

Jordan 

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


