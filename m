Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbTDJU4H (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTDJU4H (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:56:07 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:48707 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264160AbTDJU4G (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 16:56:06 -0400
Date: Thu, 10 Apr 2003 17:02:22 -0400
From: Mike Phillips <phillim2@comcast.net>
Subject: Re: setting LAA in token ring
In-reply-to: <3E94FAB6.49465DC2@tataelxsi.co.in>
To: linux-kernel@vger.kernel.org
Message-id: <20030410210222.GA28094@siasl.dyndns.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
References: <3E94FAB6.49465DC2@tataelxsi.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 10:31:42AM +0530 or sometime in the same epoch, Prasanta Sadhukhan scribbled:
> Hi,
>     Our cardbus driver   supports LAA but when
> we are giving this command 'ifconfig  tr0 hw tr 4000DEADBEEF' but we are
> getting
> SIOCSIFHWADDR: Invalid argument
> 
> Is there any prerequisites fot this command to be given?
> 

There is a requirement for certain bit in the MSB to be set, bit 6 of 7
iirc. 

Also, there is an issue with ifconfig and TR. During the 2.3 dev kernels
we changed the IEEE type of TR from 6 to a value in the 800 range. This
was done when multicast support was added as we needed to split out TR
from the other 802 protocols. 

ifconfig and friends didn't realize this and barf because the return
type is wrong. I've tried submitting patches to net-tools for this 
several times, but it wasn't fixed. It may be by now, but don't quote me
on it. 

Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net

