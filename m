Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161249AbWALUg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbWALUg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161250AbWALUg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:36:58 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:3138 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161249AbWALUg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:36:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M6Bhc2ETF4dQrA0Cxg8/McXRoSp2NwNMAlZqhAII3CXWWzUuhDLiR4R3/Gp6jWdifCCYRY9xzWJV/g346n1cPAPgVWcl7EKHA5FGlkkMGKim7bX3pBN6c28s2MPUMmFk+IbF4qMbXDsGc2dqlasI2QGKu9y8nvyfC3N46B13xSA=
Message-ID: <86802c440601121236s47d5737fo45105ce3ebc746a6@mail.gmail.com>
Date: Thu, 12 Jan 2006 12:36:55 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: can not compile in the latest git
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0601111213270.24355@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440601111021m7cb40881m7206d9342534f844@mail.gmail.com>
	 <Pine.LNX.4.62.0601111213270.24355@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out, if I disable "Support for paging of anonymous memory
(swap)" --- SWAP

the CONFIG_MIGRATION will disappear from the .config

the mm/mempolicy.c may need some #if CONFIG_MIRGRATION to comment out
these calling.

YH

On 1/11/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> On Wed, 11 Jan 2006, yhlu wrote:
>
> > : undefined reference to `putback_lru_pages'
> > make: *** [.tmp_vmlinux1] Error 1
>
> Please post your .config file.
>
>
