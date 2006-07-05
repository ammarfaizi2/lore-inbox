Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWGEVSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWGEVSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWGEVSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:18:00 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:36298 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S965033AbWGEVR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:17:59 -0400
Message-ID: <44AC2C7E.9070007@lwfinger.net>
Date: Wed, 05 Jul 2006 16:17:50 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Battery-related regression between 2.6.17-git3 and 2.6.17-git6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 14:48 -0700, Greg KH wrote:
 > On Tue, Jul 04, 2006 at 01:55:43PM +0200, Rafael J. Wysocki wrote:
 >>
 >> I'm not sure what exactly happens there, but I think hal crashes due to
 >> a buffer overflow.
 >
 > Yes, that looks like what is happening. Perhaps one of the HAL
 > developers can point you at a patch that you can apply to your version
 > of HAL to get it working.
 >
 > Either way, this is not a kernel bug, as it could have happened with any
 > very long depth device tree, you were just lucky it didn't happen
 > sooner.

It is definitely a buffer overflow in hald. I reproduced the problem by a 'hald --daemon=no' 
command. On my SuSE 10.0 system, the problem was fixed by downloading and installing hal-0.5.7.

Larry

