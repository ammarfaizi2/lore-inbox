Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317013AbSF0Wuc>; Thu, 27 Jun 2002 18:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317014AbSF0Wuc>; Thu, 27 Jun 2002 18:50:32 -0400
Received: from w007.z208177138.sjc-ca.dsl.cnc.net ([208.177.141.7]:58498 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S317013AbSF0Wub>;
	Thu, 27 Jun 2002 18:50:31 -0400
Subject: Re: Status of capabilities?
From: Dax Kelson <dax@gurulabs.com>
To: Chris Wright <chris@wirex.com>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
       Michael Kerrisk <m.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020627135422.B26112@figure1.int.wirex.com>
References: <1025157926.1652.35.camel@mentor>
	<200206271257.HAA61267@tomcat.admin.navo.hpc.mil> 
	<20020627135422.B26112@figure1.int.wirex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jun 2002 16:52:33 -0600
Message-Id: <1025218353.3997.33.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-27 at 14:54, Chris Wright wrote:
> * Jesse Pollard (pollard@tomcat.admin.navo.hpc.mil) wrote:
> > 
> > Actually, I think most of that work has already been done by the Linux
> > Security Module project (well, except #7).
> 
> The LSM project supports capabilities exactly as it appears in the
> kernel right now.  The EA linkage is still missing.  Of course, we are
> accepting patches ;-)

Has either lscap or chcap been written? I suppose not as that would
require a consensus on how capabilities would be stored as a EA. 

That EA would need to be "special" and only be changeable by uid 0 (or
CAP_CHFSCAP).

So, has any of the below changed now that LSM has entered the picture?

1. Define how capabilities will be stored as a EA
2. Teach fs/exec.c to use the capabilities stored with the file
3. Write lscap(1)
4. Write chcap(1)
5. Audit/fix all SUID root binaries to be capabilities aware
6. Set appropriate capabilities with for each with chcap(1) and then:
   # find / -type f -perm -4000 -user root -exec chmod u-s {} \;
7. Party and snicker in the general direction of that OS with the slogan
"One remote hole in the default install, in nearly 6 years!"

Dax Kelson

