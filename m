Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTB1W1a>; Fri, 28 Feb 2003 17:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268215AbTB1W13>; Fri, 28 Feb 2003 17:27:29 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:36356
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265567AbTB1W13>; Fri, 28 Feb 2003 17:27:29 -0500
Subject: Re: [Bug 420] New: Divide by zero 
	(/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)
From: Robert Love <rml@tech9.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, ak@suse.de, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030228142625.1a53da75.rddunlap@osdl.org>
References: <27440000.1046453828@[10.10.2.4].suse.lists.linux.kernel>
	 <p733cm86yv0.fsf@amdsimf.suse.de> <3E5FE165.C8BABD4@libero.it>
	 <20030228142625.1a53da75.rddunlap@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046471866.1346.267.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 28 Feb 2003 17:37:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 17:26, Randy.Dunlap wrote:

> I agree with that.

I agree with that, too.

It is easy, too, because the sysctl mechanism has a built-in bounds
checking function.

For the seventh parameter (the parsing mechanism) you can specify
something like proc_dointvec_minmax and then the last parameters can be
&one and NULL.  This forces the minimum value to be one.

So its trivial and built-in.  While root should be able to wreck the
system, he should at least have a chance in hell of knowing he is doing
so.  Zero may seem to be a legitimate value here...

	Robert Love

