Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269415AbUINSnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269415AbUINSnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269499AbUINSlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:41:14 -0400
Received: from pyxis.pixelized.ch ([213.239.200.113]:20648 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S269492AbUINSdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:33:36 -0400
Message-ID: <41473972.8010104@debian.org>
Date: Tue, 14 Sep 2004 20:33:22 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, greg@kroah.com
CC: Tigran Aivazian <tigran@veritas.com>
Subject: udev is too slow creating devices
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people!

When I load a module (with modprobe) the relative device is too
slowly created with udev, so modprobe return before the device
is really created. Because of this my init.d script will
fail with modular microcode + udev

test case:

udev + modular microcode:
$ modprobe -r microcode
$ modprobe microcode ; microcode_ctl -u
=> microcode_ctl does NOT find the device

$ modprobe -r microcode
$ modprobe microcode ; sleep 3; microcode_ctl -u
=> microcode_ctl FIND the device

[without udev it is OK, so I assume no errors
in modprobe]

Is it a bug of udev?
Else what workaround I can use? (sleep is to slow for
an already to sloow system initialitation)


ciao
	cate
