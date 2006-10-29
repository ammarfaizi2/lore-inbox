Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWJ2QRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWJ2QRw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWJ2QRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:17:52 -0500
Received: from ns1.suse.de ([195.135.220.2]:18108 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965191AbWJ2QRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:17:51 -0500
From: Andi Kleen <ak@suse.de>
To: Horst Schirmeier <horst@schirmeier.com>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Date: Sun, 29 Oct 2006 08:16:55 -0800
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
       Sam Ravnborg <sam@ravnborg.org>, jpdenheijer@gmail.com,
       linux-kernel@vger.kernel.org, dsd@gentoo.org, draconx@gmail.com,
       kernel@gentoo.org
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de> <20061029120858.GB3491@quickstop.soohrt.org>
In-Reply-To: <20061029120858.GB3491@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610290816.55886.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why not use -o /dev/null, as Daniel Drake already suggested in [1]? In
> both as-instr and ld-option, the tmp file is being deleted
> unconditionally right after its creation anyways.

Because then when the compilation runs as root some as versions
will delete /dev/null on a error. This has happened in the past.

-Andi
