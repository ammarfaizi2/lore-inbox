Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbULWCWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbULWCWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 21:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbULWCWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 21:22:35 -0500
Received: from legolas.drinsama.de ([62.91.17.164]:38615 "EHLO
	legolas.drinsama.de") by vger.kernel.org with ESMTP id S261155AbULWCW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 21:22:27 -0500
Date: Thu, 23 Dec 2004 03:19:49 +0100
From: Erich Schubert <erich@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Radeonfb driver ignores video= when panel detected
Message-ID: <20041223021949.GA16681@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
both radeon drivers will ignore the command line options "video=" when
they detect a TFT panel. They will always use 8 bit color depth then.

I have a Thinkpad A31p with Radeon Mobility graphics.
Since I'd like to try out bootsplash/gensplash I'd like to run 16 bit
color depth. I needed to change this in the kernel
(in drivers/video/radeonfb.c: radeon_update_default_var(),
drivers/video/aty/radeon_monitor.c: struct ... radeonfb_default_var)
because the video= command line option that works fine on other boxes
with radeons I have doesn't work.

Did I miss some other option?

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    Go away or i'll replace you with a very small shell script.     //\
           Es ist besser, geliebt und verloren zu haben,            V_/_
                   als niemals geliebt zu haben.
