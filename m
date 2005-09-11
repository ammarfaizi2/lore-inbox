Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVIKVe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVIKVe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVIKVe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:34:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750930AbVIKVeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:34:25 -0400
Date: Sun, 11 Sep 2005 14:33:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
cc: Sam Ravnborg <sam@ravnborg.org>, Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
In-Reply-To: <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com> <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Linus Torvalds wrote:
> 
> The _git_ network transport is. rsync and http aren't.

Btw, there's no reason why a client-side thing couldn't just parse the 
"alternates" thing, and if it doesn't find the objects in the main object 
directory, go and fetch them from the alternates itself.

IOW, this is not a fundamental problem with alternates, it's just that
since there is no server-side smarts to handle it (ie just raw file access
with rsync/http), it needs to be handled at the client side instead.

		Linus
