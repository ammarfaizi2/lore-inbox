Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVJTVXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVJTVXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVJTVXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:23:13 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:57557 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S932521AbVJTVXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:23:12 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] fix vgacon blanking
To: Pozsar Balazs <pozsy@uhulinux.hu>, linux-kernel@vger.kernel.org,
       7eggert@gmx.de
Reply-To: 7eggert@gmx.de
Date: Thu, 20 Oct 2005 23:23:01 +0200
References: <4ZLja-4gH-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EShsL-0000tJ-Fr@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs <pozsy@uhulinux.hu> wrote:

> This patch fixes a long-standing vgacon bug: characters with the bright
> bit set were left on the screen and not blacked out.
> All I did was that I lookuped up some examples on the net about setting
> the vga palette, and added the call missing from the linux kernel, but
> included in all other ones. It works for me.

This is strange, since according to my documentation, the value should have
been initialized to 0xff and never been changed. Can you test setting this
value during initialisation (around line 259, if I read correctly) instead?
I don't know if I can test it myself soon enough.

(I'm not the maintainer, I just happen to have some documentation).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
