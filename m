Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWATTuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWATTuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWATTuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:50:55 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63160
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932117AbWATTuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:50:55 -0500
Date: Fri, 20 Jan 2006 11:46:13 -0800 (PST)
Message-Id: <20060120.114613.54096131.davem@davemloft.net>
To: laforge@netfilter.org
Cc: torvalds@osdl.org, bboissin@gmail.com, xslaby@fi.muni.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Iptables error
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060120193201.GP4603@sunbeam.de.gnumonks.org>
References: <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
	<Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
	<20060120193201.GP4603@sunbeam.de.gnumonks.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Welte <laforge@netfilter.org>
Date: Fri, 20 Jan 2006 20:32:01 +0100

> The problem seems to have been accidentially introduced by DaveM's
> "simplification" of my original patch.
> 
> I've already asked Dave to revert his change and apply my original
> patch (see attachment), which _should_ fix the problem.

Your struct won't be 8-byte aligned either as far as I
can tell on x86_64.

We need to use the aligned_u64 thing if you want that.
