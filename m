Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWFTATB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWFTATB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWFTATB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:19:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:16862 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965008AbWFTATA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:19:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PdtWkNtlq2kXusdQCDaf4ToOKonpCp8UzUVjqpzbVbpVwwW/LVqipOwgZ+heYcQLUqxfPvT+00BoHfHAxiJN9QilwQb5VVHy2UZRKvQsBu3xPlU8y4yz/6IrcYMi2xyljeMqp3gtlM+raIAID/ewDIcoxx3YsyWP/fyHrLYHooQ=
Message-ID: <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
Date: Mon, 19 Jun 2006 20:18:59 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <44957026.2020405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44957026.2020405@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave this patch a try and it seems to work. I say seems because I
could not get the nvidiafb driver to set a usable mode after it was
bound/unbound. That's not a problem with the patch, the patch is not
addressing that issue. I tried vbetool but it kept GPFing. This is a
patch to help developers so maybe someone will fix nvidiafb to be more
friendly.

Is there any way to lessen this problem? Would it help if fbcon worked
with text modes, or would it be better for each driver to set in a
default mode that it understands when it gets control? The fbdev
driver should not set a mode when it loads, but that doesn't mean
fbcon can't set one when it is activated. Similarly VGAcon would set
the mode (and load its fonts) when it regains control.

It would also be interesting to make VGAcon a modular driver. You
could build in fbcon and then work on VGAcon.

-- 
Jon Smirl
jonsmirl@gmail.com
