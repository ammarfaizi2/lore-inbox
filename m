Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264518AbUESTso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbUESTso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 15:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUESTso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 15:48:44 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:56242 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264518AbUESTsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 15:48:41 -0400
Date: Wed, 19 May 2004 21:48:20 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519194820.GB16202@fi.muni.cz>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org> <20040519103855.GF18896@fi.muni.cz> <20040519105805.GK30909@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519105805.GK30909@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
:         int                     error;
: 
:         VOP_SENDFILE(vp, filp, ppos, 0, count, actor, target, NULL, error);
:         return error;
: }
: 
: (note error is int, not ssize_t), but I don't see anything obvious
: for other filesystems.
: 
	Yes, this fixed the problem - now I can sendfile() the whole
DVD image without problem. Thanks, and send both these fixes to Linus.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
