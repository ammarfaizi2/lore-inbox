Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264042AbUECVek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbUECVek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbUECVek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:34:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58278 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264103AbUECVeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:34:20 -0400
Date: Mon, 3 May 2004 22:34:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity removal)
Message-ID: <20040503213419.GH17014@parcelfarce.linux.theplanet.co.uk>
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org> <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk> <4095BAA3.3050000@keyaccess.nl> <20040503055934.GA17014@parcelfarce.linux.theplanet.co.uk> <40968A9F.6070608@keyaccess.nl> <20040503194558.GF17014@parcelfarce.linux.theplanet.co.uk> <4096B810.5060907@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4096B810.5060907@keyaccess.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 11:22:24PM +0200, Rene Herman wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> >>However, any "cp" from cd-rom oopses the box.
> >
> >oopses in driver, oopses by triggering BUG() or oopses in fs/*?  The last
> >two would be more interesting - isofs _MUST_ be able to survive any IO
> >errors, simply because CDs get scratched, etc. and that shouldn't crash
> >the box.
> 
> Doesn't actually look all driver. The CD is good; works fine in this 
> same drive with its own 2.0 kernel (and on other drives). Please note, 
> this is a 386. Memory is good. dmesg and .config attached.
> 
> Very long crash, but in case it's helpful. Happens when copying anything 
> from the sbpcd CD-ROM. In between the "do_exit, do_divide_error, 
> do_page_fault, do_page_fault" oopses it seems to be attempting to give 
> me back a prompt (it's not succeeding).

Almost certainly a driver-induced memory corruption.
