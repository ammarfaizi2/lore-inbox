Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbUKQKrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUKQKrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUKQKrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:47:09 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:61709 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S262261AbUKQKp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:45:56 -0500
Message-ID: <419B4451.3010104@gentoo.org>
Date: Wed, 17 Nov 2004 12:30:09 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] raw1394: sysfs support via class_simple
References: <4196D308.60801@gentoo.org> <200411140142.56071.dtor_core@ameritech.net>
In-Reply-To: <200411140142.56071.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.9 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CUNJy-000GVY-Dr*khPLZWXbgXQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hmm, with the exception of raw1394, the rest of ieee1394 subsystem does
> not need its own classes as 1394 devices hook up into other subsystems
> (SCSI, NET) and are classified with the rest of the devices in those
> systems. After all userspace does not really care whether eth0 is on
> PCI, ISA or IEEE1394, all it needs to know that it is just another network
> interface. Am I missing something?

No, I think I was. I was trying to follow the way that USB does it (e.g. usblp 
linking into the usb sysfs class) but I think you are right - IEEE1394 is in a 
different situation. raw1394 is the only ieee1394 driver (as far as I can see) 
that might benefit fitting into a generic class. I think we should stick with 
class_simple and possibly consider a generic class if more drivers might 
require it in the future.

Daniel
