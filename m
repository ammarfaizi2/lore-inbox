Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWFGEZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWFGEZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 00:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWFGEZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 00:25:20 -0400
Received: from gw.goop.org ([64.81.55.164]:19348 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750837AbWFGEZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 00:25:19 -0400
Message-ID: <44862434.2070805@goop.org>
Date: Tue, 06 Jun 2006 17:56:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Andrew Morton <akpm@osdl.org>, Don Zickus <dzickus@redhat.com>, ak@suse.de,
       shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org> <200606071013.53490.ncunningham@linuxmail.org> <44861D37.7050301@goop.org> <200606071034.03228.ncunningham@linuxmail.org>
In-Reply-To: <200606071034.03228.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> In general, you're right because we don't have perfect hardware hotplugging 
> yet. But cpu hotplugging is one area we do have, so it should work.
Well, it seems to me the general problem is generating the proper 
hotplug events.  If you actually pull, say, a USB device, the usb 
subsystem will tell you about it as it happens.  But if you can suspend 
the machine and then arbitrarily rearrange the hardware, then on resume 
you'd have to go over the current hardware state and compare it to the 
pre-suspend state and generate all those events.  Or I guess you could 
just generate unplug events for everything at suspend and re-plug 
anything you find on resume.  Sounds pretty heavyweight though.

    J

