Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbTEBQkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTEBQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:40:37 -0400
Received: from mail.coastside.net ([207.213.212.6]:38278 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP id S263001AbTEBQkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:40:36 -0400
Mime-Version: 1.0
Message-Id: <p05210604bad8521898a8@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.53.0305021116340.9129@chaos>
References: <20030502090835.GX10374@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0305021131290.493-100000@joel.ro.ibrro.de>
 <20030502095018.GY10374@parcelfarce.linux.theplanet.co.uk>
 <200305021003.33638.kevcorry@us.ibm.com>
 <Pine.LNX.4.53.0305021116340.9129@chaos>
Date: Fri, 2 May 2003 09:52:30 -0700
To: root@chaos.analogic.com, Kevin Corry <kevcorry@us.ibm.com>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
Cc: viro@parcelfarce.linux.theplanet.co.uk, Bodo Rzany <bodo@rzany.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:27am -0400 5/2/03, Richard B. Johnson wrote:
>If your conversion chances the base to 0, you divide by 0 (not
>good) and don't get a remainder. Actually  procedure number()
>protects against a base less than 2 or greater than 36 so you
>just prevent conversion altogether.

A bug in number(), looks like. (base = 0) is intended to let the 
input string determine the base (16 if 0x*, else 8 if 0* else 10). 
Like simple_strtol().
-- 
/Jonathan Lundell.
