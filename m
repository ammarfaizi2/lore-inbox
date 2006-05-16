Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWEPOsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWEPOsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWEPOsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:48:33 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:18703 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750879AbWEPOsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:48:32 -0400
Date: Tue, 16 May 2006 16:48:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060516164846.4d42ed11.khali@linux-fr.org>
In-Reply-To: <20060516145517.2c2d4fe4.khali@linux-fr.org>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	<20060515115302.5abe7e7e.akpm@osdl.org>
	<6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
	<20060515122613.32661c02.akpm@osdl.org>
	<6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>
	<20060516103930.0c0d5d33.khali@linux-fr.org>
	<20060516145517.2c2d4fe4.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski reported:
> > When I try to "modprobe -r i2c_i801" modprobe hangs

Quoting myself:
> I can reproduce it, with both i2c-i801 and i2c-parport, so it's not
> related to a specific driver. I'm currently performing a bisection on
> 2.6.17-rc4-mm1 to try and isolate the culprit. It seems to point to
> gregkh-driver-*. i2c patches are innocent for sure, including Kumar's
> ones.

And the winner is...
gregkh-driver-driver-core-class_device_add-needs-error-checks.patch

Stephen, Greg?

-- 
Jean Delvare
