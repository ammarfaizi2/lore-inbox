Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUCDS4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUCDSw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:52:57 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11757 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262076AbUCDSuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:50:18 -0500
Subject: Re: [ANNOUNCE] kpatchup 0.02 kernel patching script
From: Dave Hansen <haveblue@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040304183516.GN3883@waste.org>
References: <20040303022444.GA3883@waste.org>
	 <1078420922.19701.1362.camel@nighthawk>  <20040304183516.GN3883@waste.org>
Content-Type: text/plain
Message-Id: <1078426209.19701.1382.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 10:50:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 10:35, Matt Mackall wrote:
> I skimmed latest-kernel-version, is it doing something my -s option
> doesn't do yet?

$ ./kpatchup-0.03 -s 2.6-bk
2.6.4-rc1-bk4
$ ./kpatchup-0.03 -s 2.6
2.6.3
$ ./kpatchup-0.03 -s 2.6-pre
2.6.4-rc2
$ latest-kernel-version --probe
2.6.4-rc2

I might be misunderstanding the options, but 'kpatchup -s' I think is
limited to giving the latest version of a single tree, while
'latest-kernel-version' will look at several different trees.  This is a
tiny problem for kpatchup because it treats 2.6, 2.6-bk, and 2.6-pre as
separate trees.  For my use, I just want the latest snapshot, whether
it's a bk snapshot, or one of the real point releases.  

What I'm doing to work around it is this:
kpatchup `latest-kernel-version --probe`

-- dave

