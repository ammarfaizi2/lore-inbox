Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTDPWsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTDPWsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:48:20 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23456 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261835AbTDPWsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:48:19 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 17 Apr 2003 01:00:05 +0200 (MEST)
Message-Id: <UTC200304162300.h3GN05X17159.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, jamie@shareable.org
Subject: Re: [PATCH] kill ide-geometry.c, fix boot problems
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jamie Lokier <jamie@shareable.org>

    Andries.Brouwer@cwi.nl wrote:
    > Now the RedHat installer can do the remap in case it detects
    > a disk manager. That is nice, because that means that in case of
    > a whole-disk install it could ask the user whether she wants to
    > preserve this animal. Probably she doesnt.

    That is quite nice - ask user at install time whether to remove the
    disk manager.

    However, after doing that it seems appropriate for a booting kernel to
    autodetect the presence or absence of the disk manager and behave
    accordingly.

Once the redhat installer has determined that there really
is a disk manager, and that the user wants it that way, it can
add the boot parameter hda=remap63.

I dislike autodetection. The word sounds so nice. But a synonym
is guessing.

If kernel guessing is required it means that some interface is missing.
Policy should be determined from userspace.

But of course, it is easy to add some heuristic code.
I would prefer to keep such code out of the vanilla kernel,
but a vendor might want it.

[And note that todays patch did not remove any DM detection.
This discussion is 37 patch levels late.]


Andries
