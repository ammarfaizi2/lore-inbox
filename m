Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423591AbWJZSD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423591AbWJZSD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423610AbWJZSD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:03:58 -0400
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:3522 "EHLO
	smtp-out0.tiscali.nl") by vger.kernel.org with ESMTP
	id S1423591AbWJZSD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:03:57 -0400
Subject: keyboard scancode problems
From: Joost Gevers <joost.gevers@tiscali.nl>
Reply-To: joost.gevers@tiscali.nl
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 20:03:56 +0200
Message-Id: <1161885837.6083.19.camel@venus>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've a laptop with 2 additional keys for the Euro and Dollar (Acer 
TM8106). 

When I press these keys, I get the following error: 
atkbd.c: Unknown key pressed (translated set 2, code 0xb3 on
isa0060/serio0). 
atkbd.c: Use 'setkeycodes e033 <keycode>' to make it known. 
atkbd.c: Unknown key released (translated set 2, code 0xb3 on
isa0060/serio0). 
atkbd.c: Use 'setkeycodes e033 <keycode>' to make it known. 

When I use setkeycodes to link a keycode to a scancode, as shown below: 

setkeycodes 0xb3 205 

(I think that this is the same as: 
setkeycodes e033 205 
At least it gives identical results) 

To make the key know as Euro key, I do the following: 
loadkeys << "EOF" 
keycode  205 = currency 
EOF 

This results in a the Euro sign on my console with 
setfont lat0-16 -m 8859-15 

Now my question: 
When I do a showkey -s, I expect that when I press the Euro key, which
I 
just linked to 0xb3 will be shown. But the following is the result: 
showkey -s 
kb mode was XLATE 

press any key (program terminates after 10s of last keypress)... 
0x9c 
0xe0 0x25 
0xe0 0xa5 

What is the reason that the scancode which I set differs from what is 
shown by showkey? 

With kind regards 
Joost Gevers 



