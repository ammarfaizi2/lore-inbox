Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVAUMLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVAUMLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAUMLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:11:31 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:17875 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262347AbVAUML3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:11:29 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Reply-To: 7eggert@gmx.de
Date: Fri, 21 Jan 2005 13:11:22 +0100
References: <fa.f2nt105.94e81t@ifi.uio.no> <fa.ihdogs4.bjglrq@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CrxdQ-0000n9-9c@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Holbe <Mario.Holbe@TU-Ilmenau.DE> wrote:

> I understand the point that the device's blocksize affects the device's
> length... obviously a block device can only consist of full blocks,
> not half a block or something like that.
> However, if that's right, a block device's length should IMHO also be
> affected by it's blocksize - thus, the block device should return an
> EOF after the last block was read.

This would shut up the error message while still hiding the possibly (0.001%)
valuable data in the last block. Even if it's the right thing for almost any
user, the error message should stay and report this error. Instead, the
cause of this message should be documented.
