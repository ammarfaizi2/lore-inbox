Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271731AbTGXUxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271732AbTGXUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 16:53:43 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32018 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S271731AbTGXUxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 16:53:41 -0400
Date: Thu, 24 Jul 2003 23:08:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: yiding_wang@agilent.com
Cc: rddunlap@osdl.org, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 module loading issue
Message-ID: <20030724210848.GB1176@mars.ravnborg.org>
Mail-Followup-To: yiding_wang@agilent.com, rddunlap@osdl.org,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D55226@axcs03.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334DD5C2ADAB9245B60F213F49C5EBCD05D55226@axcs03.cos.agilent.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 11:11:24AM -0600, yiding_wang@agilent.com wrote:
> Hello Randy,
> 
> Thanks for the response.  I did not get time to look into this till now.  The way you suggested is to add module build process into kernel build.  This requires a user to build a loadable module with kernel together.  What I really want to is to have module build alone but include kernel symbols and variables so it will not have problem when loading.  The benefit of doing it is to make user and developer easy to change the code and rebuild without experiencing the kernel rebuild process every time.  I read those two documents and they mainly talking about how to build module with kernel together.

Please break your lines - they are very long..

It is well known that building drivers outside the kernel tree is not
supported in 2.6.0-test yet. This is one of the two issues remaining before
kbuild is ready. You will see them present on Andrew Morton's must-fix
list.

> In2.4.x, there is a "Rules.make" which has all needed symbols and variables defined.  I just includes that file for my module build and everything works perfectly.  Now in 2.5.x, those structure has been changed and the "rule" files seem to be relocated under "scripts" and being changed too.  I am trying to make use of those "rules" to make module build and load simpler compare with build module with kernel each time.
> 
> Any ideas?

Wait a little more, and it will be possible to build modules in a clean
way outside the kernel tree.

	Sam
