Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbUKJLzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUKJLzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 06:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbUKJLzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 06:55:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:50106 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261735AbUKJLze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 06:55:34 -0500
Date: Wed, 10 Nov 2004 12:55:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Airlie <airlied@linux.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: kconfig/build question..
In-Reply-To: <Pine.LNX.4.58.0411100110170.1637@skynet>
Message-ID: <Pine.LNX.4.61.0411101253460.17266@scrub.home>
References: <Pine.LNX.4.58.0411100110170.1637@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Nov 2004, Dave Airlie wrote:

> So what I want to do and what I think Kbuild can't do is:
> 
> if CONFIG_AGP=n then CONFIG_DRM can be n,m,y
> if CONFIG_AGP=m then CONFIG_DRM can be m but not y
> if CONFIG_AGP=y then CONFIG_DRM can be m,y

Do you really want to say that DRM can't be disabled if AGP is enabled?
Otherwise this should do it:

	depends on AGP || AGP=n

bye, Roman
