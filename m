Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWDHTXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWDHTXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 15:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWDHTXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 15:23:41 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:14486 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751243AbWDHTXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 15:23:41 -0400
From: Dan Dennedy <dan@dennedy.org>
To: linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
Date: Sat, 8 Apr 2006 12:18:24 -0700
User-Agent: KMail/1.9
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Adrian Bunk <bunk@stusta.de>,
       scjody@modernduck.com, linux-kernel@vger.kernel.org
References: <20060406224706.GD7118@stusta.de> <44374FC0.3070507@s5r6.in-berlin.de>
In-Reply-To: <44374FC0.3070507@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604081218.24544.dan@dennedy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 22:53, Stefan Richter wrote:
> Adrian Bunk wrote:
> > This patch contains the overdue removal of the RAW1394_REQ_ISO_SEND and
> > RAW1394_REQ_ISO_LISTEN request types plus all support code for them.
>
> [...]
>
> I am not familiar with the isochronous part of Linux' 1394 software
> stack, so I can't comment whether there are high-profile applications
> which still did not migrate away from this interface, or did so only
> recently.

Kino still uses the legacy raw1394 iso interface for capture by default; 
however, it can also still use dv1394. I will accellerate the adoption of the 
new raw1394 interface since I have already done this for dvgrab 2.0. 
Cinelerra supports libiec61883 now.

Unfortunately, gstreamer still uses legacy raw1394 iso interface, but I can 
nag someone at Fluendo. I think another high profile app that might be 
affected is GnomeMeeting/Ekiga, but I have not kept close track of it.

Also, I have not released a version of libraw1394 that contains the 
deprecation warnings, but I can do so this weekend. And then another release 
when the removed kernel interfaces are released that removes the functions. 
