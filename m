Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbSI3Oml>; Mon, 30 Sep 2002 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSI3Oml>; Mon, 30 Sep 2002 10:42:41 -0400
Received: from dsl-213-023-038-108.arcor-ip.net ([213.23.38.108]:62865 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262116AbSI3Omk>;
	Mon, 30 Sep 2002 10:42:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       torvalds@transmeta.com
Subject: Re: [patch] avoid reference to struct page before it's declared
Date: Mon, 30 Sep 2002 16:44:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200209282056.g8SKu1i2009029@napali.hpl.hp.com>
In-Reply-To: <200209282056.g8SKu1i2009029@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17w1n1-0005oF-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 September 2002 22:56, David Mosberger wrote:
> GCC currently warns when page-flags.h gets included before struct page
> is declared.  Patch below fixes this.

A better way is to compile struct page and related structure definitions
right at the beginning of mm.h, before declaring any helper functions.  I
posted a patch to do this, earlier in 2.4, and should bring it forward.

-- 
Daniel
