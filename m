Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbUKDO3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbUKDO3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbUKDO0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:26:42 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:42469 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262229AbUKDOXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:23:13 -0500
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 14:23:12 +0000 (UTC)
Organization: Wurtelization
Message-ID: <cmde0g$l20$1@news.cistron.nl>
References: <20041103194226.GA23379@DervishD> <418965E0.8070508@tmr.com> <20041104102655.GB23673@DervishD>
X-Trace: ncc1701.cistron.net 1099578192 21568 195.64.88.114 (4 Nov 2004 14:23:12 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD  <lkml@dervishd.net> wrote:
>
>    If init is the parent, all works ok, just wait a bit and all
>those zombies will really die ;)

I recently had a system with serial console where some some reason the
serial port was stopped. This meant that init blocked while writing some
message (e.g. "respawning too rapidly"), and that meant it stopped
reaping those zombie processes. The list of these zombie processes with
PPID == 1 was amazing. The only thing that helped was rebooting after
replacing the serial console cable.

(Kernel 2.4.25, sysvinit 2.85 in case you're wondering.)


Paul Slootman

