Return-Path: <linux-kernel-owner+w=401wt.eu-S1751990AbXARLSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXARLSR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 06:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXARLSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 06:18:17 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:32796 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbXARLSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 06:18:16 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K/82NCxaWwKnBhIYSFevFGCfVGPKvlr9eOGwqasGetcXlzZXMpOyvDuceVm99eFdNZWjvFYglbTQ2GsvSPu5QNsy3y8tkPc8X7wm3XJruGkhtg+NLwWTs4ZnNUnbNzoVvqoMttHWrCTLj/4e0k8kC0DMtUvHHwP0NxiYhdpyKis=
Message-ID: <fb6b09f20701180318i5f3b2785sd7f3f0931808b849@mail.gmail.com>
Date: Thu, 18 Jan 2007 06:18:14 -0500
From: "Sue Alfano" <smalfano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: uClibc - waitid()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone help with this?

We have an application that runs fine on our linux workstations, but
will not compile to run on a new target.  This application is using
the WNOWAIT option for the waitid() function.  When the source file is
compiled for the target using powerpc-uclibc-gcc, it fails because
WNOWAIT is not defined.  The best that I can tell, waitid() doesn't
appear to be supported in uClibc (version 0.9.27).  I checked the
latest version on the uClibc site, but it doesn't appear to have been
considered for inclusion.  I looked in glibc (versions 2.4, 2.3.5, and
2.0.6), but could only find emulated/stub/pseudo implementations for
waitid().  The Linux man page for waitid() states that it's supported
since the 2.6.9 kernel release.  At this point I'm not sure where the
waitid() source code and WNOWAIT definition is suppose to be (kernel,
uClibc, glibc, gcc) or what version of wait.h is actually being used
(there appears to be many versions floating around on the machine).
Since I'm way off in the weeds on this I was hoping somebody with more
Linux experience than me (that would be just about anyone) might be
able to shed some light on this problem or point me in a more
constructive direction.

Do you have any information as to the status of the waitid() support?
It must have been available at one time since it's running on my linux
workstation (Linux version 2.6.15-1.2054_FC5smp
(bhcompile@hs20-bc1-3.build.redhat.com) (gcc version 4.1.0 20060304
(Red Hat 4.1.0-3)) #1 SMP Tue Mar 14 16:05:46 EST2006).

Was there a reason why it wasn't added to uClibc (other than the size issue)?

Is there a recommended way to deal with applications that are using
waitid() with the WNOWAIT option?

Thanks for any assistance,
Sue
