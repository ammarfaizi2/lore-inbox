Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269880AbUIDLJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269880AbUIDLJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269881AbUIDLJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:09:42 -0400
Received: from main.gmane.org ([80.91.224.249]:8623 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269880AbUIDLJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:09:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: claus@xn--frber-gra.muc.de (=?ISO-8859-1?Q?Claus_F=E4rber?=)
Subject: Re: silent semantic changes with reiser4
Date: 03 Sep 2004 15:23:00 +0200
Message-ID: <9G9vIAK3cDD@gmane.3247.org>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
	<412E4999.1050504@sover.net> <9FuGrTY3cDD@3247.org>
	<1094051610.2777.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e92122.dip.t-dialin.net
User-Agent: OpenXP/3.9.8-cvs (Win32; Delphi)
Cc: reiserfs-list@namesys.com, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> schrieb/wrote:
> On Maw, 2004-08-31 at 12:01, Claus Färber wrote:
>> A simple convention that meta data files start with, say ".$", would
>> be enough.

> POSIX/SuS don't permit this. The only "free" namespace is that starting
> "//" (and not as some desktops seem to think foo://). Remember always
> send GUI desktop users files called http://read.me  .. its fun 8)

Well, the problem is that one does want the metadata to be in the
ordinary namespace so that they are accessible with POSIX tools.
(The current version of) POSIX does not have a "unified" namespace so a
unified namespace can't be POSIX.

I wonder if it makes sense to have an environment variable (maybe
POSIXLY_CORRECT) to switch between POSIX and the unified namespace
model. Of course, this would mean that all of this is handled in
userspace (e.g. libc), whereas the kernel and filesystems export more
"traditional" (e.g. with openat) interfaces. Accessing metadata as
ordinary files would then work with other filesystems, too.

Claus
-- 
http://www.faerber.muc.de


