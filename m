Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVILDkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVILDkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 23:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVILDkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 23:40:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbVILDkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 23:40:00 -0400
Date: Sun, 11 Sep 2005 20:39:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: Sam Ravnborg <sam@ravnborg.org>, Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
In-Reply-To: <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.58.0509112038020.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com> <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
 <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Junio C Hamano wrote:
> 
> For kernel.org, you could say '/pub/scm/blah' in your alternates
> and expect it to work, only because http://kernel.org/pub
> hierarchy happens to match the absolute path /pub on the
> filesystem, but for most people's default HTTP server
> installation, they would need to say /var/www/scm/blah to have
> alternate work locally, but somebody has to know that the named
> directory is served as http://machine.xz/pub/scm/blah somewhere.

Yes. We should probably have some well-defined meaning for relative paths
in there regardless (eg just define that they are always relative to the
main GIT_OBJECT_DIRECTORY or something).

That would also allow mirrors to mirror the git archives in different 
places, without upsetting the result (as long as they are mirrored 
together).

		Linus
