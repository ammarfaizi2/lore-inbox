Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTJJRQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTJJRQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:16:42 -0400
Received: from email.careercast.com ([216.39.101.233]:62936 "HELO
	email.careercast.com") by vger.kernel.org with SMTP id S263017AbTJJRQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:16:41 -0400
Subject: Re: 2.7 thoughts
From: Matt Simonsen <matt_lists@careercast.com>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F864F82.4050509@longlandclan.hopto.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
	 <20031009115809.GE8370@vega.digitel2002.hu>
	 <20031009165723.43ae9cb5.skraw@ithnet.com>
	 <3F864F82.4050509@longlandclan.hopto.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065805958.2806.22.camel@mattswrk.cbd.careercast.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 Oct 2003 10:12:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 23:19, Stuart Longland wrote:
> 	- Software RAID 0+1 perhaps?
> 
> 		A lot of hardware RAID cards support it, why not the
> 		kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more) 		stripe-RAID 
> arrays.  (Or can this be done already?)


You can do this now (as you rightly suspected). 

Just create 2 raid 0 arrays (md0, md1). From there create md2 as a RAID1
array using /dev/md0 and /dev/md1. Create the filesystem and you've got
yourself RAID 0+1. 

You can do RAID 5+0 or any other wild combo you could think of.

Matt

