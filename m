Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270028AbUJHQv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270028AbUJHQv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270037AbUJHQv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:51:56 -0400
Received: from open.hands.com ([195.224.53.39]:45522 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S270028AbUJHQvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:51:54 -0400
Date: Fri, 8 Oct 2004 18:03:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008170300.GM5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net> <41669DE0.9050005@didntduck.org> <20041008151837.GI5551@lkcl.net> <1097248370.26463.0.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097248370.26463.0.camel@tara.firmix.at>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 05:12:51PM +0200, Bernd Petrovitsch wrote:

> >  my alternative is to patch every single vfs-related sys_* in fs/*.c to
> >  be able to "plug in" to these functions.
> 
> Why not implement it in user-space?
 
 that is the base that i am working from (fuse).

 the problem comes when adding support to fuse for xattrs, and the
 subsequent use of those xattrs for SE/Linux.

 security/selinux/hooks.c cannot cope with the -512 response
 "please try later" which the fuse module always always always
 sends, in order for fuse to give the userspace daemon a chance
 to wake up and smell the roses.

 ... and i sure ain't gonna hack selinux about!
 
 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

