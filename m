Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUIOSou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUIOSou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUIOSou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:44:50 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:24268 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267278AbUIOSoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:44:46 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
	<m3ekl5de7b.fsf@telia.com> <20040914094928.GF27258@bytesex>
	<m33c1kxz3f.fsf@telia.com> <20040915070841.GA29586@bytesex>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Sep 2004 20:44:41 +0200
In-Reply-To: <20040915070841.GA29586@bytesex>
Message-ID: <m3zn3rpe1y.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> writes:

> > I found the change that crashes my computer. This patch is enough to
> > fix it for me:
> > 
> > -			if (!yoffset)
> > -				chroma = (line & 1) == 0;
> > -			else
> > -				chroma = (line & 1) == 1;
> 
> Does the one below work as well?
...
> -				chroma = (line & 1) == 0;
> +				chroma = ((line & 1) == 0);

No, that patch makes no difference, because == has higher precedence
than = in C. (I also verified that this patch doesn't change the
generated object code, so compiler bugs aren't an issue either.)

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
