Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWJ2CIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWJ2CIA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWJ2CH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:07:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55442 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932120AbWJ2CH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:07:59 -0400
From: Andi Kleen <ak@suse.de>
To: Horst Schirmeier <horst@schirmeier.com>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Date: Sat, 28 Oct 2006 19:07:19 -0700
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
       Sam Ravnborg <sam@ravnborg.org>, jpdenheijer@gmail.com,
       linux-kernel@vger.kernel.org, dsd@gentoo.org, draconx@gmail.com,
       kernel@gentoo.org
References: <20061028230730.GA28966@quickstop.soohrt.org>
In-Reply-To: <20061028230730.GA28966@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281907.20673.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 16:07, Horst Schirmeier wrote:
> Hello,
>
> the kbuild-dont-put-temp-files-in-the-source-tree.patch (-mm patches) is
> implemented faultily and fails in its intention to put temporary files
> in $TMPDIR (or /tmp by default).
>
> This is the code as it results from the patch:
>
> ASTMP = $(shell mktemp ${TMPDIR:-/tmp}/asXXXXXX)

I'm still against mktemp. It eats random entropy and
temporary files should be in the objdir, not in /tmp

-Andi
