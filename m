Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUADAdM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbUADAdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:33:12 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:33037 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264366AbUADAdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:33:11 -0500
Message-ID: <3FF75D26.5070009@myrealbox.com>
Date: Sat, 03 Jan 2004 16:24:06 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Technical udev question for Greg
References: <3FF72A4C.2040404@myrealbox.com> <20040103214750.GB11061@kroah.com>
In-Reply-To: <20040103214750.GB11061@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Jan 03, 2004 at 12:47:08PM -0800, walt wrote:

>>I acidentally ran a script which ran MAKEDEV
>>while udev was running.
>>
>>Now /dev/.udev.tdb is very large and devices have strange permissions
>>they didn't have before.


> As udev didn't get called when runinng MAKEDEV, I don't see how the udev
> database could have grown.

Well, after doing the steps below the size of the db didn't seem any
smaller, true enough.


>>All I want to do is delete all the extraneous devices in .udev.tdb
>>and start over.  How do I do that?


> 	rm -rf /dev/*
> 	rm -f /dev/.udev.tdb
> 	/etc/init.d/udev start

However, after doing the above and recreating a few missing devices
the behavior of the machine seems back to normal, so clearly I did
something that mattered.  I don't pretend to understand how or why,
but thanks.
