Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbREEJWe>; Sat, 5 May 2001 05:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbREEJWZ>; Sat, 5 May 2001 05:22:25 -0400
Received: from www.linux.org.uk ([195.92.249.252]:29700 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S131460AbREEJWQ>;
	Sat, 5 May 2001 05:22:16 -0400
Date: Sat, 5 May 2001 10:21:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Duncan Gauld <duncan@gauldd.freeserve.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible README patch
Message-ID: <20010505102133.A16788@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	Duncan Gauld <duncan@gauldd.freeserve.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01050510040100.05769@pc-62-31-91-153-dn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01050510040100.05769@pc-62-31-91-153-dn>; from duncan@gauldd.freeserve.co.uk on Sat, May 05, 2001 at 10:04:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 10:04:01AM -0400, Duncan Gauld wrote:
> Information in the README file says that when patching, the -p0 option is 
> used with patch (eg tar xvzf <patch>.tar.gz | patch -p0).

You probably have done:

gzip -dc linux-2.4.XX.tar.gz | tar zvf -
cd linux
gzip -dc patchXX.gz | patch -p0

which will fail since the patch file specifies all files with a path
starting with 'linux/'.  However, the instructions in the README are
for the following situation:

gzip -dc linux-2.4.XX.tar.gz | tar zvf -
gzip -dc patchXX.gz | patch -p0

which may work, but note that patch can be a little tempremental about
the filenames it chooses from the patch file.  The absolute safest way
to apply a patch is:

gzip -dc linux-2.4.XX.tar.gz | tar zvf -
cd linux
gzip -dc patchXX.gz | patch -p1


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

