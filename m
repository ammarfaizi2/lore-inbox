Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUBYDMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUBYDMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:12:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12770 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262574AbUBYDMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:12:14 -0500
Cc: linux-kernel@vger.kernel.org, boutcher@us.ibm.com,
       Hollis Blanchard <hollisb@us.ibm.com>
To: Greg KH <greg@kroah.com>, Ryan Arnold <rsa@us.ibm.com>
Subject: Re: new driver (hvcs) review request and sysfs questions
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com> <20040225012845.GA3909@kroah.com>
Message-ID: <opr3woijnwl6e53g@us.ibm.com>
From: Dave Boutcher <sleddog@us.ibm.com>
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Tue, 24 Feb 2004 21:12:09 -0600
In-Reply-To: <20040225012845.GA3909@kroah.com>
User-Agent: Opera7.23/Win32 M2 build 3227
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 17:28:45 -0800, Greg KH <greg@kroah.com> wrote:

> On Tue, Feb 24, 2004 at 06:00:26PM -0600, Ryan Arnold wrote:
>> An example of the vio bus's "devices" sysfs directory is shown below.
>>
>> Pow5:/sys/bus/vio/devices # ls
>> .               l-lan@3000000c  l-lan@30000010       vty-server@30000004
>> ..              l-lan@3000000d  rtc@4001             vty@30000000
>> IBM,sp@4000     l-lan@3000000e  v-scsi@30000002
>> l-lan@3000000b  l-lan@3000000f  vty-server@30000003
>
> At first glance, why are you using text strings as part of your bus ids?
> Bus ids must be unique, so it looks like you can do this by just using
> the number after the '@' character, right?

That naming convention (e.g. l-lan@3000000c) is what is defined in the 
IEEE Standard for Boot (Initialization Configuration) Firmware spec, and 
what gets presented by Open Firmware.  It is what has been used in things 
like /proc/device-tree on the Power platforms forever, and thus was 
carried over into the sysfs definitions.

It is also true that it is unlike the representation of most other things 
in sysfs, so perhaps this is the time to change before it gets too baked 
into things.

Dave B

