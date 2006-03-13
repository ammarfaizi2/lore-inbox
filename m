Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWCMQ50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWCMQ50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWCMQ50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:57:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751524AbWCMQ5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:57:25 -0500
Date: Mon, 13 Mar 2006 11:57:19 -0500
From: Bill Nottingham <notting@redhat.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>,
       ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060313165719.GB4147@devserv.devel.redhat.com>
Mail-Followup-To: Kay Sievers <kay.sievers@vrfy.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Andrew Morton <akpm@osdl.org>, ambx1@neo.rr.com,
	linux-kernel@vger.kernel.org
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312172332.GA10278@vrfy.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers (kay.sievers@vrfy.org) said: 
> There is no need to rush out with this half-baken solution. This simple
> udev rule does the job for you, if you want pnp module autoloading with
> the current kernel:
>   SUBSYSTEM=="pnp", RUN+="/bin/sh -c 'while read id; do /sbin/modprobe pnp:d$$id; done < /sys$devpath/id'"

See:
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=178998

This doesn't work for everything.

Bill
