Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270461AbTHLPw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTHLPw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:52:57 -0400
Received: from mta2-svc.business.ntl.com ([62.253.164.42]:18652 "EHLO
	mta2-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S270461AbTHLPwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:52:55 -0400
Date: Tue, 12 Aug 2003 16:54:05 +0100 (BST)
From: William Gallafent <william.gallafent@virgin.net>
X-X-Sender: williamg@officebedroom.oldvicarage
To: Valdis.Kletnieks@vt.edu
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error 
In-Reply-To: <200308121503.h7CF3JfZ009007@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0308121652020.13364@officebedroom.oldvicarage>
References: <m21xvrynnk.wl%ysato@users.sourceforge.jp>           
 <m2y8xzx74x.wl%ysato@users.sourceforge.jp> <200308121503.h7CF3JfZ009007@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 Valdis.Kletnieks@vt.edu wrote:

> On Tue, 12 Aug 2003 23:50:06 +0900, Yoshinori Sato
> <ysato@users.sourceforge.jp> said:
> > -	while (count) {
> > +	while (count > 1) {
>
> Given that count is a size_t, which seems to be derived from 'unsigned int'
> or 'unsigned long' on every platform, how are these any different?

Er, consider the case of count == 1. Fenceposts can be dangerous things.

-- 
Bill Gallafent.
