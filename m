Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUEBQ2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUEBQ2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 12:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUEBQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 12:28:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21663 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263154AbUEBQ2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 12:28:47 -0400
Date: Sun, 2 May 2004 17:28:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: GNU/Dizzy <dizzy@roedu.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Filesystem with multiple mount-points
Message-ID: <20040502162842.GX17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58L0.0405021712280.31153@ahriman.bucharest.roedu.net> <Pine.LNX.4.44.0405021806460.1477-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405021806460.1477-100000@poirot.grange>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 06:18:20PM +0200, Guennadi Liakhovetski wrote:
> See "not nice" above. With the proposed option I would like to avoid
> having one file appear at multiple paths. IOW each file would appear in no
> more than 1 place in the tree.

<shrug>

mount <whatever> /tmp/blah
mount --bind /tmp/blah/relative_path /desired_mountpoint
umount -l /tmp/blah

and you've got an exact equivalent of your "mount a subtree".
