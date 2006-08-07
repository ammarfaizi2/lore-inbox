Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWHGH5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWHGH5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWHGH5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:57:48 -0400
Received: from mail.gmx.de ([213.165.64.20]:39862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751137AbWHGH5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:57:48 -0400
X-Authenticated: #428038
Date: Mon, 7 Aug 2006 09:57:44 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Edward Shishkin <edward@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060807075744.GA8894@merlin.emma.line.org>
Mail-Followup-To: Edward Shishkin <edward@namesys.com>,
	Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com> <20060803140344.GC7431@merlin.emma.line.org> <44D219F9.9080404@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D219F9.9080404@namesys.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-08-05)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[stripping Cc: list]

On Thu, 03 Aug 2006, Edward Shishkin wrote:

> >What kind of forward error correction would that be,
> 
> Actually we use checksums, not ECC. If checksum is wrong, then run
> fsck - it will remove the whole disk cluster, that represent 64K of
> data.

Well, that's quite a difference...

> Checksum is checked before unsafe decompression (when trying to
> decompress incorrect data can lead to fatal things).

Is this sufficient? How about corruptions that lead to the same checksum
and can then confuse the decompressor? Is the decompressor safe in that
it does not scribble over memory it has not allocated?

-- 
Matthias Andree
