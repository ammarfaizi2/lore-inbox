Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVAMSRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVAMSRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVAMSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:14:40 -0500
Received: from mail.enyo.de ([212.9.189.167]:64401 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261348AbVAMSIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:08:12 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: write barriers - Was: Re: [RFC][PATCH] problem of	cont_prepare_write()
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
	<1101121403.18623.10.camel@imp.csi.cam.ac.uk>
	<20041122135354.38feab51.akpm@osdl.org>
	<Pine.LNX.4.60.0411222324150.27573@hermes-1.csi.cam.ac.uk>
	<20041122154325.4d8e53ef.akpm@osdl.org>
	<1105627627.22536.30.camel@imp.csi.cam.ac.uk>
	<41E69A28.9080900@nortelnetworks.com>
Date: Thu, 13 Jan 2005 19:08:10 +0100
In-Reply-To: <41E69A28.9080900@nortelnetworks.com> (Chris Friesen's message of
	"Thu, 13 Jan 2005 09:56:24 -0600")
Message-ID: <87is61gq2d.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Friesen:

> I believe so.  You may also need to cast them as volatile to prevent the 
> compiler from reordering--can someone with more gcc knowledge than I 
> state definitively whether or not it is smart enough to not reorder 
> barriers?

If you define it properly, GCC won't reorder it (volatile __asm__ with
memory operands should be sufficient).
