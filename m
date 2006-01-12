Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWALW5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWALW5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWALW5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:57:11 -0500
Received: from canuck.infradead.org ([205.233.218.70]:12264 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161395AbWALW5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:57:10 -0500
Subject: Re: git status (was: drm tree for 2.6.16-rc1)
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
       len.brown@intel.com, axboe@suse.de, sfrench@us.ibm.com,
       rolandd@cisco.com, wim@iguana.be, aia21@cantab.net,
       linux@dominikbrodowski.net
In-Reply-To: <20060112140713.770be59c.akpm@osdl.org>
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
	 <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
	 <20060112134255.29074831.akpm@osdl.org>
	 <1137102945.3621.1.camel@pmac.infradead.org>
	 <20060112140713.770be59c.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 22:57:09 +0000
Message-Id: <1137106630.3085.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 14:07 -0800, Andrew Morton wrote:
> Well it's oopsing in the audit code, and might not oops without audit. 
> Perhaps the audit code is being called before i_sb is fully set up or
> something.  We won't know until we know.
> 
> Did we work out why i_sb is crazy?

No, we didn't. He disabled auditing (which he never really wanted in the
first place, but Fedora Core 4 stupidly enables it by default), then I
believe his last mail reported a BUG() in skb_under_panic(). It all
looks fairly random to me.

-- 
dwmw2

