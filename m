Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271822AbTGXXRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271817AbTGXXQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:16:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:6380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271814AbTGXXPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:15:36 -0400
Date: Thu, 24 Jul 2003 16:27:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: yiding_wang@agilent.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 module loading issue
Message-Id: <20030724162753.3eb5377f.rddunlap@osdl.org>
In-Reply-To: <20030724210848.GB1176@mars.ravnborg.org>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D55226@axcs03.cos.agilent.com>
	<20030724210848.GB1176@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003 23:08:48 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:

| On Thu, Jul 24, 2003 at 11:11:24AM -0600, yiding_wang@agilent.com wrote:
| > Hello Randy,
| > 
| > Thanks for the response.  I did not get time to look into this till now.  The way you suggested is to add module build process into kernel build.  This requires a user to build a loadable module with kernel together.  What I really want to is to have module build alone but include kernel symbols and variables so it will not have problem when loading.  The benefit of doing it is to make user and developer easy to change the code and rebuild without experiencing the kernel rebuild process every time.  I read those two documents and they mainly talking about how to build module with kernel together.
| 
| Please break your lines - they are very long..
| 
| It is well known that building drivers outside the kernel tree is not
| supported in 2.6.0-test yet. This is one of the two issues remaining before
| kbuild is ready. You will see them present on Andrew Morton's must-fix
| list.
| 
| > In2.4.x, there is a "Rules.make" which has all needed symbols and variables defined.  I just includes that file for my module build and everything works perfectly.  Now in 2.5.x, those structure has been changed and the "rule" files seem to be relocated under "scripts" and being changed too.  I am trying to make use of those "rules" to make module build and load simpler compare with build module with kernel each time.
| > 
| > Any ideas?
| 
| Wait a little more, and it will be possible to build modules in a clean
| way outside the kernel tree.

Yes, my reply was/is that building modules outside of the kernel
tree isn't supported in 2.6.  I didn't know that there were plans
to fix that.

You can find some other kernel module build info at
  http://lwn.net/Articles/21823/

--
~Randy
