Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVHaX1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVHaX1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVHaX1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:27:51 -0400
Received: from hera.kernel.org ([209.128.68.125]:43155 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964984AbVHaX1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:27:50 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [Patch] Support UTF-8 scripts
Date: Wed, 31 Aug 2005 23:27:19 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <df5ecn$jo3$1@terminus.zytor.com>
References: <42FDE286.40707@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1125530839 20228 127.0.0.1 (31 Aug 2005 23:27:19 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 31 Aug 2005 23:27:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <42FDE286.40707@v.loewis.de>
By author:    =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
In newsgroup: linux.dev.kernel
>
> This patch adds support for UTF-8 signatures (aka BOM, byte order
> mark) to binfmt_script. Files that start with EF BF FF # ! are now
> recognized as scripts (in addition to files starting with # !).
> 
> With such support, creating scripts that reliably carry non-ASCII
> characters is simplified. Editors and the script interpreter can
> easily agree on what the encoding of the script is, and the
> interpreter can then render strings appropriately. Currently,
> Python supports source files that start with the UTF-8 signature;
> the approach would naturally extend to Perl to enhance/replace
> the "use utf8" pragma. Likewise, Tcl could use the UTF-8 signature
> to reliably identify UTF-8 source code (instead of assuming
> [encoding system] for source code).
> 

BOM should not be used in UTF-8.  In fact, it shouldn't be used at
all.

	-hpa
