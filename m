Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWJFTrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWJFTrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWJFTrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:47:51 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:53731 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932461AbWJFTru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:47:50 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Fri, 6 Oct 2006 19:47:41 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eg6bst$7r1$2@taverner.cs.berkeley.edu>
References: <200610052059.11714.mb@bu3sch.de> <eg4624$be$1@taverner.cs.berkeley.edu> <Pine.LNX.4.61.0610060739520.12702@yvahk01.tjqt.qr>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1160164061 8033 128.32.168.222 (6 Oct 2006 19:47:41 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Fri, 6 Oct 2006 19:47:41 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt  wrote:
>For reference, please see http://lkml.org/lkml/2006/2/22/90

Thanks.  Ok, I've read that.  That was helpful.  But I think this risk
is more serious than was realized in that thread from February.

The February thread you mention talked about the security consequences of
calling (dereferencing) a function pointer that is NULL.  The security
consequences are indeed bad.  However, that thread only discussed the
security consequences of NULL pointer bugs involving function pointers,
and there was no indication in that thread that other types of NULL
pointer bugs had any security relevance.

But now it seems, as I described in my email, that all NULL pointer bugs
(whether function pointers or not) have the potential to create security
vulnerabilities.  Every NULL pointer bug has to be viewed with suspicion,
until it has been confirmed that it cannot be exploited.  This sounds more
serious than was realized back in February.

Right?  Or am I missing something important again?
