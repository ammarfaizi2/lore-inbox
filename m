Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWKANuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWKANuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWKANuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:50:18 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:63938 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750906AbWKANuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:50:16 -0500
Date: Wed, 1 Nov 2006 06:50:15 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Holden Karau <holden@pigscanfly.ca>
Cc: Holden Karau <holdenk@xandros.com>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Message-ID: <20061101135015.GD11399@parisc-linux.org>
References: <454765AC.1050905@xandros.com> <20061031162825.GD26964@parisc-linux.org> <f46018bb0610310846p27f561b3uaf651b8d9b01c693@mail.gmail.com> <f46018bb0610311910m42029aecw42cffe2ac7eec1ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f46018bb0610311910m42029aecw42cffe2ac7eec1ee@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 10:10:39PM -0500, Holden Karau wrote:
> I was thinking about the issue of running out of memory, while its not
> particularly likely to happen except on devices with huge disks and
> tiney amount of memory, it is a possibility. I can make it
> fall-through to the previous way of doing things, does that sound like
> a reasonable idea?

Yes, or you could make it sync the ones for which you did have enough
memory, and then restart.

