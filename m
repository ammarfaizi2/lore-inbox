Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVLaUeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVLaUeL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 15:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVLaUeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 15:34:11 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:33423 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932318AbVLaUeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 15:34:09 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Reed <bradreed1@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <20051231220758.56b3e096@galactus.example.org>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136058696.6039.133.camel@localhost.localdomain>
	 <20051231220758.56b3e096@galactus.example.org>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 15:33:58 -0500
Message-Id: <1136061238.6039.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 22:07 +0200, Bradley Reed wrote:
> Steve,
> 
> Perhaps I'm doing something wrong, but it doesn't seem to apply cleanly
> here:

Make sure you're in the directory of 2.6.15-rc7-rt1 (head Makefile and
see if you see:)

----
$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 15
EXTRAVERSION =-rc7-rt1
NAME=Sliding Snow Leopard

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
----

Then in that same directory try:

patch -p1 --dry-run < my-rtc-patchfile

See if it works, and if it does try it again without the --dry-run
option.  I just tried applying it to a clean 2.6.15-rc7-rt1 and it
worked.

-- Steve


