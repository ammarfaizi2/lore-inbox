Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290692AbSARNnH>; Fri, 18 Jan 2002 08:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290691AbSARNm5>; Fri, 18 Jan 2002 08:42:57 -0500
Received: from argo.anu.edu.au ([150.203.5.57]:47492 "HELO argo.anu.edu.au")
	by vger.kernel.org with SMTP id <S290690AbSARNmt>;
	Fri, 18 Jan 2002 08:42:49 -0500
Date: Sat, 19 Jan 2002 00:42:44 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: Type-change of kdev_t
From: "Roger W.Brown" <bregor@anusf.anu.edu.au>
X-Mailer: Ishmail 2.0.0-20010429-i686-Bregor-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <20020118134245.630F6706B1@argo.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

      I'm no kernel hacker so I am little hesitant to speak; however,
  I'm looking at kdev_t.h from the linux-2.5.3-pre1 source.

  The type of kdev_t has changed recently from a scalar type to a
  structured type.  Should macro definitions such as MINOR(dev) also
  be revised to be consistent with the "new" kdev_t ?

  Something like:

  #define MINOR(dev)  ((unsigned int) ((dev.value) & MINORMASK))

  rather than

  #define MINOR(dev)  ((unsigned int) ((dev) & MINORMASK))

  Then usage of the MINOR() macro remains unchanged. 
  
  Regards,

          Roger Brown

