Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWAYXWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWAYXWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWAYXWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:22:51 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:37898 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932216AbWAYXWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:22:50 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
Subject: Re: [PATCH 2/4] pmap: remove smaps files
References: <200601222217.k0MMHDR9215012@saturn.cs.uml.edu>
From: Nix <nix@esperi.org.uk>
X-Emacs: the road to Hell is paved with extensibility.
Date: Wed, 25 Jan 2006 23:22:26 +0000
In-Reply-To: <200601222217.k0MMHDR9215012@saturn.cs.uml.edu> (Albert D.
 Cahalan's message of "22 Jan 2006 22:18:00 -0000")
Message-ID: <87vew7riz1.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2006, Albert D. Cahalan moaned:
> This patch removes the /proc/*/smaps files, which are obsolete
> and very awkward to parse. It's best to do this now, so that apps
> don't come to depend on the files. (not that app developers are
> likely to use the files at all, given the awful format)

Seconded. The *contents* are useful; the layout is not.

(I wrote a parser for smaps, it was horrible, moving to pmap
looks like it will be a joy)

> diff -Naurd 1/Documentation/filesystems/proc/pmap 2/Documentation/filesystems/proc/pmap
> --- 1/Documentation/filesystems/proc/pmap	2006-01-22 03:42:59.000000000 -0500
> +++ 2/Documentation/filesystems/proc/pmap	2006-01-22 03:24:43.000000000 -0500

Is this hunk really meant to be here? It doesn't look related to smaps
removal...

-- 
`Everyone has skeletons in the closet.  The US has the skeletons
 driving living folks into the closet.' --- Rebecca Ore
