Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUCDRXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUCDRXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:23:16 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1778 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262041AbUCDRWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:22:18 -0500
Subject: Re: [ANNOUNCE] kpatchup 0.02 kernel patching script
From: Dave Hansen <haveblue@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040303022444.GA3883@waste.org>
References: <20040303022444.GA3883@waste.org>
Content-Type: text/plain
Message-Id: <1078420922.19701.1362.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 09:22:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 18:24, Matt Mackall wrote:
> This is an alpha release for people to experiment with. Feedback and
> patches encouraged. Grab your copy today at:

First of all, very nice script.

But, it doesn't look like it properly handles empty directories.  I
tried this command, this morning, and it blew up.  I think it's because
this directory http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/ is
empty because of last night's 2.6.4-rc2 release.  I don't grok python
very well but is the "return p[-1]" there just to cause a fault like
this?  Would it be better if it just returned a "no version of that
patch right now" message and exited nicely?

[dave@nighthawk linux-2.6]$ kpatchup-0.02 2.6-bk
"Traceback (most recent call last):
  File "/home/dave/bin/kpatchup-0.02", line 283, in ?
    b = find_ver(args[0])
  File "/home/dave/bin/kpatchup-0.02", line 240, in find_ver
    return v[0](os.path.dirname(v[1]), v[2])
  File "/home/dave/bin/kpatchup-0.02", line 147, in latest_dir
    return p[-1]
IndexError: list index out of range

I think your script, combined with Rusty's latest-kernel-version could
make me a very happy person.  

-- dave

