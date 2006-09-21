Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWIUUfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWIUUfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWIUUfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:35:41 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:36731 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S1751275AbWIUUfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:35:41 -0400
X-IronPort-AV: i="4.09,196,1157342400"; 
   d="scan'208"; a="9967695:sNHT18817946"
Message-Id: <6.1.1.1.0.20060921162935.01ecb8c0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Thu, 21 Sep 2006 16:35:48 -0400
To: Dave Jones <davej@redhat.com>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: drivers/char/random.c exported interfaces
Cc: Dmitry Torokhov <dtor@insightbb.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones pondered:
>Under what circumstances is it desirable to allow INPUT=m ?

I know there are some people using it in their embedded product. I don't 
exactly know _why_, but last time I checked it was to ensure that the 
kernel was as small as possible - which reduces boot time, and their kernel 
flash footprint (kernel and file system are seperate).

The input subsystem is one of the last to be initialized in their system, 
so it allows a little more flexibility in their overall system design.

-Robin 
