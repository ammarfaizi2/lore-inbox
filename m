Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUIOPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUIOPpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUIOPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:45:22 -0400
Received: from pyxis.pixelized.ch ([213.239.200.113]:30126 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S266490AbUIOPpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:45:13 -0400
Message-ID: <4148637F.9060706@debian.org>
Date: Wed, 15 Sep 2004 17:45:03 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
CC: Ian Campbell <icampbell@arcom.com>, Greg KH <greg@kroah.com>,
       "Marco d'Itri" <md@Linux.IT>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
References: <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org> <1095258966.18800.34.camel@icampbell-debian> <20040915152019.GD24818@thundrix.ch>
In-Reply-To: <20040915152019.GD24818@thundrix.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tonnerre wrote:
> 
> On Wed, Sep 15, 2004 at 03:36:06PM +0100, Ian Campbell wrote:
> 
>>I wonder if it would be feasible for modprobe (or some other utility) to
>>have a new option: --wait-for=/dev/something which would wait for the
>>device node to appear. Perhaps by:
>>	- some mechanism based on HAL, DBUS, whatever
>>	- dnotify on /dev/?
>>	- falling back to spinning and waiting.
> 
> 
> This would  end up  as hideous misfeature  as you can't  guarantee the
> device to show up *at* *all*.
> 
> The reason udev is there is that we can dynamically respond to created
> device nodes and  devices that show up. They  might have changed since
> the last boot. Maybe they don't show up at all.
> 
> Thus you should trigger your actions from /etc/dev.d.

It is right.
But an option --wait would be sufficient.
This option will require modprobe to wait (with a timeout of
x seconds) that hotplug event finish (so if device is created or
not is no more a problem).
Ideally this should be done modifing only hotplug and IMHO
should be enabled by default.

ciao
	cate
