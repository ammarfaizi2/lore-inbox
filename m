Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUIOOBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUIOOBD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUION7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:59:06 -0400
Received: from pyxis.pixelized.ch ([213.239.200.113]:13960 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S266465AbUIONzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:55:49 -0400
Message-ID: <414849CE.8080708@debian.org>
Date: Wed, 15 Sep 2004 15:55:26 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Marco d'Itri" <md@Linux.IT>, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com>
In-Reply-To: <20040914230409.GA23474@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Sitting and waiting is a band-aid, I agree.  That's why we created the
> /etc/dev.d/ notifier system to fix this issue (that is there for systems
> that don't even use udev.)

Hello Greg!

[note that I really appreciate udev].

You said me to use dev.d, but really I don't see it as a working
solution. Maybe because I missinterpreted the documentation,
so maybe you can give me some hints.

Real case: distribution boot script.
It should work with non udev kernel, udev non modular kernel and
udev very modular kernel. The script load (directly or not) a module
and need the device impelmented by module.

Old behaviour (modprobe "waits" for the creation of device):
normal init.d script, with normal boot priorities.

New behaviour (dev.d). What I should do?
My init.d script is loaded with priority XX, so
I require that dev.d on my device is executed after
boot priority XX (else I don't have the needed
functionalities), also in case of non-udev or non modular kernel.
How should I implement script in dev.d/?

I see some design problems in dev.d/, or am I wrong?

ciao
	cate


PS: - What are the best (on topic) mailing list?
     - What do other distributions?
