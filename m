Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290974AbSAaGgY>; Thu, 31 Jan 2002 01:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290975AbSAaGgQ>; Thu, 31 Jan 2002 01:36:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14863 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290974AbSAaGgC>; Thu, 31 Jan 2002 01:36:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Date: 30 Jan 2002 22:35:59 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3aokf$1l5$1@cesium.transmeta.com>
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F4@BUFORD.littlefeet-inc.com> <20020130163730.N763@lynx.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020130163730.N763@lynx.adilger.int>
By author:    Andreas Dilger <adilger@turbolabs.com>
In newsgroup: linux.dev.kernel
> 
> <stating the obvious>
> Rather than mounting the device to try and see if it is already
> mounted, use /proc/mounts or /etc/mtab or "df" or "mount" output
> instead.  Doctor, it hurts when I do this... ;-).
> </stating the obvious>
> 

ENOTATOMIC

Might not matter for a human user, but for a daemon like autofs it's
vital that atomicity is preserved.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
