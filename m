Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbSASWFt>; Sat, 19 Jan 2002 17:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSASWDS>; Sat, 19 Jan 2002 17:03:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19987 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287532AbSASWCL>; Sat, 19 Jan 2002 17:02:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [question] implentation of smb-browsing: kernel space or user
 space?
Date: 19 Jan 2002 14:01:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2cqc9$2fc$1@cesium.transmeta.com>
In-Reply-To: <E16RtOX-0007Ao-00@mrvdom00.kundenserver.de> <Pine.LNX.4.33.0201191313170.4434-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0201191313170.4434-100000@cola.teststation.com>
By author:    Urban Widmark <urban@teststation.com>
In newsgroup: linux.dev.kernel
> > 
> > I think that using the smb-file-system with a user-space mounter like 
> > mkautosmb has the problem of bad scalability in large networks, because it 
> > scans the whole network before you can access one share.
> 
> You don't need to scan on every access. You could run the scanner only if
> it was more than x minutes since the last scan. You could run the scanner
> independently of any attempts to access autofs.
> 

There is probably no need to even do that.  SMB contains a browser
list protocol, and Samba (nmbd) can participate in it.  You should be
able to read it out of there.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
