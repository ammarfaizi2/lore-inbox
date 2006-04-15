Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWDOPC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWDOPC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 11:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWDOPC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 11:02:26 -0400
Received: from thunk.org ([69.25.196.29]:8619 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030269AbWDOPCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 11:02:25 -0400
Date: Sat, 15 Apr 2006 11:02:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dustin Kirkland <dustin.kirkland@us.ibm.com>,
       Kylene Jo Hall <kjhall@us.ibm.com>, kbuild-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make: add modules_update target
Message-ID: <20060415150208.GB19708@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dustin Kirkland <dustin.kirkland@us.ibm.com>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	kbuild-devel@lists.sourceforge.net,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1145027216.12054.164.camel@localhost.localdomain> <20060414170222.GA19172@thunk.org> <1145061219.4001.25.camel@localhost.localdomain> <20060415084058.GA29502@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415084058.GA29502@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 10:40:58AM +0200, Sam Ravnborg wrote:
> The problem to be solved is the long time it takes to do
> "make modules_install" when working on a single module.
> Instead of bringing in more or less complex solutions what about
> extending "make dir/module.ko" to include the installation of the
> module.
> 
> Something like:
> "make MI=1 dir/module.ko"
> where MI=1 tells us to install the said module.

Um, wouldn't that imply that either (a) the compile is being done as
root, or (b) the /lib/modules/* is writeable by a non-root userid?  I
suppose the install command could be prefixed by sudo, but that seems
awkward (and not everyone uses sudo).

						- Ted
