Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUAHTiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUAHTh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:37:56 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:34820 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266085AbUAHTe4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:34:56 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Diego Calleja <grundig@teleline.es>, Ian Kent <raven@themaw.net>
Subject: Re: udev and devfs - The final word
Date: Thu, 8 Jan 2004 22:25:01 +0300
User-Agent: KMail/1.5.3
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
References: <E1Aeab1-0009FQ-00.arvidjaar-mail-ru@f20.mail.ru> <Pine.LNX.4.44.0401082333280.449-100000@donald.themaw.net> <20040108182621.1278db90.grundig@teleline.es>
In-Reply-To: <20040108182621.1278db90.grundig@teleline.es>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401082220.24127.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 January 2004 20:26, Diego Calleja wrote:
> El Thu, 8 Jan 2004 23:40:16 +0800 (WST) Ian Kent <raven@themaw.net> 
escribió:
> > Again I'm also unable to find descriptions of the 'unsolvable' races.
> >
> > I wouldn't mind knowing what they are either. Anyone?
>
> You can find tons of examples (several of them patches by Al Viro to fix
> them) by searching with google with keywords like "devfs races". The
> "should fix" list
> (http://www.kernel.org/pub/linux/kernel/people/akpm/must-fix) has this:
>

is it a gospel?

> hch: devfs: there's a fundamental lookup vs devfsd race that's only
>   fixable by introducing a lookup vs devfs deadlock.  I can't see how this
> is fixable without getting rid of the current devfsd design.  Mandrake
> seems to have a workaround for this so this is at least not triggered so
> easily, but that's not what I'd consider a fix..

oh, well ... if you selected this example ...

Mandrake workaround it mentions was my first attempt to fix this; this did not 
fix the devfs but rather fixed the user-space program that provoked this on 
boot (and that was buggy irrespectively of this problem).

Current 2.6 kernel includes my fix to deadlock condition. Current -mm includes 
one possible fix for race condition; Andrew Morton mentioned that it is 
unlikely to be accepted due to minor changes in VFS layer; I am working on 
another less intrusive fix and overall devfs cleanup.

Would you please instead of citing long obsolete paper show me real example 
and explain *why* it is not fixable. Better yet, would you take some time to 
try to provoke any of those huge races and report back your success (stack 
trace and instructions how to reproduce them are welcome :)

Thank you

-andrey

