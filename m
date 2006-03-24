Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWCXTPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWCXTPD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWCXTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:15:01 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:60044 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964786AbWCXTPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:15:01 -0500
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time
	through fs-wide dirty bit]
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Valerie Henson <val_henson@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com,
       zach.brown@oracle.com
In-Reply-To: <20060324185237.GB18020@thunk.org>
References: <20060322011034.GP12571@goober>
	 <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
	 <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org>
	 <20060324143239.GB14508@goober>  <20060324185237.GB18020@thunk.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 24 Mar 2006 11:14:54 -0800
Message-Id: <1143227694.4561.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 13:52 -0500, Theodore Ts'o wrote:
> On Fri, Mar 24, 2006 at 06:32:39AM -0800, Valerie Henson wrote:
> > Note that ext3's habit of clearing indirect blocks on truncate would
> > break some things I want to do in the future. (Insert secret plans
> > here.)
> 
> This is fixable, but it would require making the truncate code (even
> more) complicated.....
> 
> 						- Ted
> 

Andreas suggested to perform asynchronous unlink/truncate to reduce the
latency of truncating/unlink before. What's other options we discussed
before, I forget.


> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

