Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWCIDRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWCIDRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWCIDRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:17:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932317AbWCIDRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:17:07 -0500
Date: Wed, 8 Mar 2006 22:16:50 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>
Subject: Re: + stack-corruption-detector.patch added to -mm tree
In-Reply-To: <200603082041.k28Kf7H1027435@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.63.0603082215330.4484@cuia.boston.redhat.com>
References: <200603082041.k28Kf7H1027435@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, akpm@osdl.org wrote:

> -			memset(ret, 0, THREAD_SIZE);		\
> +			memset(ret, 0x55, THREAD_SIZE);		\

Xen uses 0x55 as a poison pattern too.  I wonder if we should
change this one (this one's newer ;)) to something else.

-- 
All Rights Reversed
