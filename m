Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269466AbSKEDcR>; Mon, 4 Nov 2002 22:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276347AbSKEDcR>; Mon, 4 Nov 2002 22:32:17 -0500
Received: from dp.samba.org ([66.70.73.150]:56517 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S276343AbSKEDcO>;
	Mon, 4 Nov 2002 22:32:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.15474.340596.779207@gargle.gargle.HOWL>
Date: Tue, 5 Nov 2002 14:35:14 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: "Geoff Gustafson" <geoff@linux.co.intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
In-Reply-To: <016601c28464$6f6d1110$7fd40a0a@amr.corp.intel.com>
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com>
	<15815.2399.566974.940599@gargle.gargle.HOWL>
	<016601c28464$6f6d1110$7fd40a0a@amr.corp.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2002/11/4 16:44-0800  Geoff Gustafson writes:
> One issue is that this new project is primarily concerned with
> testing parts of the spec that have not been fully supported in
> Linux so far. These are the kind of things that are not included in
> LSB yet, so they wouldn't be appropriate in LSB's test suite.

Actually we do include some areas that aren't yet in the LSB spec or
fully supported by Linux (eg aio) in the LSB test suites we release -
they just aren't run by default - but it is easy to enable them.

> utterly minimal. So far, each test case has its own main() function
> and a bare minimum of surrounding code.  The idea is that when a bug
> is found, this one .c file can be sent to the appropriate developer,
> and without any learning curve, they have the ability to find their
> bug. I don't think LKML wants to see TET code posted here. :)

Yes, I agree TET does have a significant learning curve, and I do end
up writing small test programs that don't include the TET stuff before
sending off bug reports.

I have however seen some advantages - It is nice when you get a test
failure the report tells you exactly which part of the specification
you're violating. Once you do understand the TET/vsxgen library calls
testcases look much simpler - and if you're aiming for complete
functionality coverage including all the tricky corner cases for
various interfaces which can require quite a bit of setup code to get
into the right situation I think you'll end up having to write helper
libraries anyway.

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
