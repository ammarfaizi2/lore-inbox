Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286371AbSAEXUi>; Sat, 5 Jan 2002 18:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286374AbSAEXUb>; Sat, 5 Jan 2002 18:20:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2823 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286371AbSAEXUS>; Sat, 5 Jan 2002 18:20:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: losetuping files in tmpfs fails?
Date: 5 Jan 2002 15:20:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a181n5$tm3$1@cesium.transmeta.com>
In-Reply-To: <20020105215147.GH136@pervalidus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020105215147.GH136@pervalidus>
By author:    =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
In newsgroup: linux.dev.kernel
>
> On a side note, why do I need to use losetup -d after umount
> when /etc/mtab is a symlink to /proc/mounts ?
> 
> mount or loop "feature" ?
> 

/proc/mounts, unlike /etc/mtab, doesn't tell umount(8) that this was a
loopback created by mount(8) as opposed to a preexisting loopback
created by losetup(8).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
