Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTLaPFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTLaPFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:05:50 -0500
Received: from postbode01.zonnet.nl ([62.58.50.88]:59316 "EHLO
	postbode01.zonnet.nl") by vger.kernel.org with ESMTP
	id S265161AbTLaPFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:05:48 -0500
From: S Ait-Kassi <sait-kassi@zonnet.nl>
To: linux-kernel@vger.kernel.org
Subject: VESA fb weirdness in 2.6.0 kernel
Date: Wed, 31 Dec 2003 16:07:38 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312311607.38342.sait-kassi@zonnet.nl>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.1; VDF: 6.23.0.1; host: postbode01.zonnet.nl)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having the same problem that has come to mention before in the mailing 
list but hasn't been fixed since.

I have been having the problem since a late 2.5 kernel (2.5.70 I believe) 
before that I was using a 2.4 kernel with vesafb and didn't have any 
complaints. The most apparent occurrence of the problem for me is when 
running mc (Midnight Commander). The blue blackground isn't drawn in the 
parts where there is no text. When using mcedit this comes all the more clear 
and  particularly when scrolling is done. The space which hasn't got any text 
is replaced with RGB pixels (looks grey from a distance). If you jump back 
from one console and back again the screen is redrawn correctly.

I checked if using ypan, ywrap or redraw would make a difference and also
passed the other options through (mtrr,nomtrr ect.). Checked if the options 
where taken by checking dmesg which was indeed the case. But I found that the 
problem still continued to occur. It am using a resolution of 1024x768x24 
(0x318). 

I thought that maybe the redraw wasn't working since the redraw was faster 
than under 2.4 allbut the problem mentioned in 2.6  and I thought it might be 
using ypan by mistake. But since my card seems to handly ypan and ywrap under 
2.4 I do  think that the cause lies in the vesafb implementation in the 2.6 
kernel.

The only other overlap I found was with the author of the following message to 
the mailing list concerning the same problem I believe is the use of an ATI 
card. His was a Radeon 7000 mine is a Radeon 9500.

Here is and excerpt of the message:

>"VESA fb weirdness in 2.6.0-test4-mm4"
From: Petr Baudis
>Date: Sun Aug 31 2003 - 08:36:36 EST
>
>when using VESA fb on 2.6.0-test4-mm4, some areas of the screen, in
>particular those which have background set but space on that spot (or other
>blank character), the area is drawn with thin vertical lines of other color
>over them (bluespace is shown as magenta with thin cyan lines over it, 
>redspace
>is shown as darkgreen with darkred lines over it). Ie. in menuconfig, the 
>blue
>background shows such an effect, as well as the active item highlight in mutt
>mails list.

I'm already compiling different kernels to see where the problem started and 
have been looking in to the source to see if I can make sense of the changes.
Too bad that the console and vesa parts have been seperated making it a lot
harder for a novice like myself to find the cause. I'll be back on this if I 
find out more.

Regards,

S Ait-Kassi

