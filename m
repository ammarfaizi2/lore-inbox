Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVILSXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVILSXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVILSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:23:13 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:46544 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932124AbVILSXM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:23:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g7jz+SdceMelp/H/oY09LnYxEMx35X8KAHOLilQznCKGFYVxqbFVy1x/hZm9RCvbTpZRo6sCWiRaj5/sifvV3GCwS0/fvkq8Rl5R7/KE7/KqPc0jwx+2oj1bL2/AGMYrJfpEcvWlzF37yXCuSIg6z/ohsQrhkiuu2Jjwpg+w1Rg=
Message-ID: <12c511ca050912112266470d8b@mail.gmail.com>
Date: Mon, 12 Sep 2005 11:22:58 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: tony.luck@gmail.com
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Cc: Roland Dreier <rolandd@cisco.com>, Sam Ravnborg <sam@ravnborg.org>,
       Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m3mzmjvbh7.fsf@telia.com>
	 <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	 <20050911185711.GA22556@mars.ravnborg.org>
	 <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
	 <20050911194630.GB22951@mars.ravnborg.org>
	 <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
	 <52irx7cnw5.fsf@cisco.com>
	 <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/05, Linus Torvalds <torvalds@osdl.org> wrote:
> There is such an anonymous server, btw: "git-daemon" implements anonymous
> access much more efficient than rsync/http. Sadly, kernel.org still
> doesn't offer it (but it's now used in the wild, ie I've done a couple of
> merges with people running the git daemon).

Should the git daemon take a look at objects/info/alternates to check
that if it exists, it
points to a repository that also has a "git-daemon-export-ok" file?  
I don't see that this
could be used for anything nasty, but it does provide a loophole where
the daemon may
open files outside the initial repository ... so a sanity check seems in order.

-Tony
