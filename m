Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTH1Vs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTH1Vs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:48:29 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:42735 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S264259AbTH1Vs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:48:28 -0400
Message-ID: <3F4E796E.5090203@cornell.edu>
Date: Thu, 28 Aug 2003 17:51:42 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030816 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Novatek USB Keyboard/Mouse Bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I finally figured out why my wireless mouse turns off and on 
randomly every once in a while and works depending on the usb hub it is 
in - it's the keyboard's fault.

My mouse is:
PM: Adding info for usb:2-2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-2

My keyboard is:
PM: Adding info for usb:2-1
input: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on 
usb-0000:00:10.0-1
PM: Adding info for usb:2-1:0
input: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb-0000:00:10.0-1
PM: Adding info for usb:2-1:1


As you can see the kernel thinks it's also a mouse, which it definitely 
is not. I've previously posted this to LKML somewhere, and my 
impressions were that people don't think it's a bug, since some other 
model of that keyboard worked together with a mouse somehow. Perhaps 
that's true, but I do not have a second mouse. The kernel thinks I do, 
and switching the keyboard and the mouse usb hubs results in mouse 
devices reordering and X not working with the proper mouse (attempting 
to use the keyboard as mouse, which apparently does not work).



