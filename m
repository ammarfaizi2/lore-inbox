Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbVKQABq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbVKQABq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVKQABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:01:46 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:11743 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1030580AbVKQABp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:01:45 -0500
Date: Thu, 17 Nov 2005 01:01:44 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: X and intelfb fight over videomode
Message-ID: <20051117000144.GA29144@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the information from this thread:
http://marc.theaimsgroup.com/?t=112593256400003&r=1&w=2

I've now compiled a kernel with the intelfb and fbcon drivers linked in 
(no other fb drivers). By booting the kernel with vga=0x318 I get a 
1024x768@16bpp console and drm/agp also seems happy.

However, as soon as X starts, the following message is printed to the 
kernel log:

mtrr: base(0xe0020000) is not aligned on a size(0x300000) boundary
[drm:drm_unlock] *ERROR* Process 3013 using kernel context 0

Everything seems to work in X though. The first time that I switch 
from X to a vc, the screen stays black for a few seconds before I get 
the VC and then I get this:

intelfb: Changing the video mode is not supported.
intelfb: ring buffer : space: 61488 wanted 65472
intelfb: lockup - turning off hardware acceleration

I have X set to also use 1024x768@16bpp, what else do I need to do to 
make sure that intelfb and X play nice together?

Re,
David

PS
Please CC me on any replies

