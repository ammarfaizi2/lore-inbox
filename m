Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270378AbTHBVwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270382AbTHBVwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:52:39 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:2720 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S270378AbTHBVwh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:52:37 -0400
Date: Sat, 2 Aug 2003 23:52:46 +0200
From: Juergen Quade <quade@hs-niederrhein.de>
To: linux-kernel@vger.kernel.org
Cc: Juergen Quade <quade@postman.arcor.de>
Subject: Does Kernel 2.6 needs to call modprobe with a minor number?
Message-ID: <20030802215246.GA14636@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.6 it is possible for devices to share a major number as long
as they use different minor numbers (see register_chrdev_region).
Doesn't it mean, that now a device is clearly identified by a major
_and_ a minor number?

Right?

In this case, wouldn't it be necessary to call modprobe with
major _and_ minornumber (for example in function base_probe(),
sourcefile fs/char_dev.c)?

Otherwise the modprobe program can not clearly identify, which driver to
load.

       Juergen.
