Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261534AbSIZWor>; Thu, 26 Sep 2002 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSIZWor>; Thu, 26 Sep 2002 18:44:47 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:31503 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S261534AbSIZWoq>;
	Thu, 26 Sep 2002 18:44:46 -0400
Subject: using memset in a module
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1033080562.3371.24.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 26 Sep 2002 18:49:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem using memset in a module.

I've tried including <linux/string.h> or <asm/string.h> but whenever I
compile with gcc 2.95, the resulting object has memset being an
undefined symbol.  When I compile with gcc-3.2 it works right as is
inline in the code and there's no symbol.

has anyone seen this b4?  Is this a gcc bug? a kernel header bug? a bug
in my coding (i.e. does one have to do anything else besides include
<linux or asm/string.h> or have special gcc cmd line options that are
different from whats normally needed for a module).

if it matters, I'm using the debian gcc's

spotter@zaphod:~/cvs/zap/virtualization$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

and (cutting the cruft)
gcc version 3.2.1 20020924 (Debian prerelease)

thanks,

shaya potter (tearing his hair out)

