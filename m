Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312131AbSCQW0D>; Sun, 17 Mar 2002 17:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312128AbSCQWZp>; Sun, 17 Mar 2002 17:25:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63493 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312130AbSCQWZa> convert rfc822-to-8bit; Sun, 17 Mar 2002 17:25:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ANN: capwrap - grant capabilities to executables
Date: 17 Mar 2002 14:25:12 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a73548$4t3$1@cesium.transmeta.com>
In-Reply-To: <20020317121118.A18548@glacier.arctrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g2HMPDN00548
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020317121118.A18548@glacier.arctrix.com>
By author:    Neil Schemenauer <nas@python.ca>
In newsgroup: linux.dev.kernel
>
> I've written a small module¹ that enables the use of Linux capabilities
> on filesystems that do not support them.  It is similar in spirit to ELF
> capabilities hack² but is not specific to the ELF executable format and
> is implemented as separate kernel module.
> 
> To grant capabilities to an executable, a small wrapper file is created
> that includes the path to an executable followed a capability set
> written in hexadecimal.  When this file is executed by the kernel, the
> executable is granted the specified capabilities.  The wrapper file must
> be owned by root and have the SUID bit set.
> 
> For example, to remove the SUID bit on the ping program while retaining
> its functionality:
> 
>     # chmod -s /bin/ping
>     # mv /bin/ping /bin/ping_real
>     # echo '&/bin/ping_real 2000' > /bin/ping
>     # chmod +xs /bin/ping
> 

Why not just do this with a small program if you're doing setuid
anyway?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
