Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264034AbUECVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUECVap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbUECVaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:30:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:22407 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264096AbUECVaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:30:18 -0400
Date: Mon, 3 May 2004 14:30:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity
 removal)
In-Reply-To: <4096B810.5060907@keyaccess.nl>
Message-ID: <Pine.LNX.4.58.0405031428580.1589@ppc970.osdl.org>
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org>
 <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk>
 <4095BAA3.3050000@keyaccess.nl> <20040503055934.GA17014@parcelfarce.linux.theplanet.co.uk>
 <40968A9F.6070608@keyaccess.nl> <20040503194558.GF17014@parcelfarce.linux.theplanet.co.uk>
 <4096B810.5060907@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 May 2004, Rene Herman wrote:
> 
> Doesn't actually look all driver. The CD is good; works fine in this 
> same drive with its own 2.0 kernel (and on other drives). Please note, 
> this is a 386. Memory is good. dmesg and .config attached.

Looks like the driver seriously broke the request list, and that in turn 
corrupted memory. So the oopses are totally independent of the real bug.

Most likely a scrogged conversion to the new request handling.

		Linus
