Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVB0Ar7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVB0Ar7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVB0Ar7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:47:59 -0500
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:37385 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S261318AbVB0Arz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:47:55 -0500
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16929.6319.149849.305237@hertz.ikp.physik.tu-darmstadt.de>
Date: Sun, 27 Feb 2005 01:47:43 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <Pine.LNX.4.58.0502261546380.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
	<16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
	<Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
	<20050226225203.GA25217@apps.cwi.nl>
	<Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org>
	<20050226234053.GA14236@apps.cwi.nl>
	<Pine.LNX.4.58.0502261546380.25732@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

    Linus> On Sun, 27 Feb 2005, Andries Brouwer wrote:
    >>  (Concerning the "size" version: it occurred to me that there is one
    >> very minor objection: For extended partitions so far the size did not
    >> normally play a role. Only the starting sector was significant.  If,
    >> at some moment we decide also to check the size, then a weaker check,
    >> namely only checking for non-extended partitions, might be better at
    >> first.)

    Linus> Yes. I agree - checking the size is likely _more_ dangerous and
    Linus> likely to break something silly than checking the ID for zero.

    Linus> So your patch it is. I'll put it in immediately after doing a
    Linus> 2.6.11 (no need to worry about getting into 2.6.11, since afaik
    Linus> the worst problem right now is an extra partition that isn't
    Linus> usable).

Well,

on a Suse 9.2 System with Suse Hotplug, the phantom partition was somehow
recognized as Reiserfs, and then the Hotplug mechanism trying to mount the 
bogus partition as a Reiser Filesystem ended in an Oops...

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
