Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754312AbWKMKqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbWKMKqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 05:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbWKMKqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 05:46:06 -0500
Received: from iona.labri.fr ([147.210.8.143]:59328 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1754312AbWKMKqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 05:46:03 -0500
Message-ID: <45584CE2.7090104@ens-lyon.org>
Date: Mon, 13 Nov 2006 11:45:54 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Aubrey <aubreylee@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to add a device file to sysfs?
References: <6d6a94c50610302130u55fc3f59n7be157a73c50805e@mail.gmail.com> <20061103045235.GA24467@kroah.com>
In-Reply-To: <20061103045235.GA24467@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Oct 31, 2006 at 01:30:36PM +0800, Aubrey wrote:
>   
>> I've read the doc under linux-2.6.x/Documentation, I can add it to
>> some other directory, but not found a way to add it to my own
>> directory.
>>     
>
> After misc_register() has been successfully called, the variable "class"
> will be set in the miscdevice structure.  Use that pointer to call
> class_device_create_file() to create your new file in this directory.
>   

How does it work in -mm where miscdevice does not contain a "class"
anymore, but only pointers to some "device"?

Thanks,
Brice

