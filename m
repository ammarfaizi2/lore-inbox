Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWAEWAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWAEWAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWAEWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:00:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5257 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932233AbWAEWAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:00:12 -0500
Date: Thu, 5 Jan 2006 22:59:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Dike <jdike@addtoit.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Better diagnostics for broken configs
In-Reply-To: <20060105161436.GA4426@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
 <Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr>
 <20060105161436.GA4426@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
>>
>> What would happen if both were disabled?
>> Say, if the host system does not have SKAS and I did not want any 
>> tracing/debugging stuff?
>
>You get a UML that can't run.  TT mode isn't tracing/debugging stuff.  It's 
>a basic mode of UML operation.  Also, UML doesn't need the skas patch on
>the host in order to use skas mode any more.  It helps, but is not necessary.

config MODE_TT
        bool "Tracing thread support"
        default y
        help
        This option controls whether tracing thread support is compiled
        into UML.  Normally, this should be set to Y.  If you intend to
        use only skas mode (and the host has the skas patch applied to it),
        then it is OK to say N here.

Then I unfortunately do not quite understand what this is for.



Jan Engelhardt
-- 
