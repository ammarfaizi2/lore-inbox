Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUE1WAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUE1WAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUE1WAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:00:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58098 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264061AbUE1V74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:59:56 -0400
Message-ID: <40B7B659.9010507@mvista.com>
Date: Fri, 28 May 2004 14:59:53 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Zabolotny <zap@homelink.ru>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: two patches - request for comments
References: <20040529012030.795ad27e.zap@homelink.ru>
In-Reply-To: <20040529012030.795ad27e.zap@homelink.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, you're adding new interfaces for power management of LCD and 
backlight devices.  Since there's already LDM/sysfs interfaces for 
reading and writing power state of generic devices, is it necessary to 
add ones particular to these devices or device classes?  In other words, 
is /sys/devices/<bus>/<device>/power/state not suitable for these purposes?

And if a PM interface for device classes is needed that ties into the 
device driver suspend/resume callbacks, perhaps it can be modeled more 
closely on the existing interfaces?  These new interfaces seem to be 
intended to define: 0 == power off, 1 ==  power on.  The existing 
ACPI-inspired interfaces use: 0 == power on/full-power, 1/2/3/4 == 
low-power/off state.

New files don't have GPL license comments.

-- 
Todd
