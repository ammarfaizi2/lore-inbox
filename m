Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933883AbWK0WXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933883AbWK0WXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 17:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934176AbWK0WXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 17:23:13 -0500
Received: from main.gmane.org ([80.91.229.2]:25768 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S933883AbWK0WXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 17:23:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: Entropy Pool Contents
Date: Mon, 27 Nov 2006 23:21:40 +0100
Message-ID: <ekfoev$k3v$1@sea.gmane.org>
References: <ek2nva$vgk$1@sea.gmane.org> <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr> <ek54hf$icj$2@sea.gmane.org> <456B0F53.90209@cfl.rr.com>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e179249234.adsl.alicedsl.de
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
>> I'm mainly wondering why writing stuff to /dev/*random does not change
>> the entropy from zero to at least any low non-zero value...
> I ran into this the other day myself and when I investigated the kernel
> code, I found that writes to /dev/random do accept the data into the
> entropy pool, but do NOT update the entropy estimate.  In order to do

Heck, you're right.

Thanks, that's just the answer I was looking for.

> that, you have to use a root only ioctl to add the data and update the
> estimate.  I am not sure why this is, or if there is a tool already
> written somewhere to use this ioctl, maybe someone else can comment?

rngd seems to do, from reading the documentation.

Greetings,

  Gunter

