Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319073AbSH1XQ2>; Wed, 28 Aug 2002 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319074AbSH1XQ2>; Wed, 28 Aug 2002 19:16:28 -0400
Received: from pat.uio.no ([129.240.130.16]:51641 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S319073AbSH1XQ0>;
	Wed, 28 Aug 2002 19:16:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15725.23243.356025.364515@charged.uio.no>
Date: Thu, 29 Aug 2002 01:20:43 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
In-Reply-To: <65140000.1030568398@baldur.austin.ibm.com>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
	<shsvg5wqemp.fsf@charged.uio.no>
	<20020827200110.GB8985@tapu.f00f.org>
	<200208280009.03090.trond.myklebust@fys.uio.no>
	<19220000.1030544663@baldur.austin.ibm.com>
	<15725.5853.229315.140365@charged.uio.no>
	<65140000.1030568398@baldur.austin.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

     > I looked through your patches.  It looks like you're on the
     > right track, generally.  I am a little concerned about some of
     > the current_get*/set* functions.  I'm not entirely convinced
     > there aren't race conditions in them, but I need to think
     > harder on it.

Oh, in the current incarnation there are definitely races
w.r.t. CLONE_CRED. The objective of these 3 patches is, however, just
to introduce the basic ucred to the kernel, so that we can get on with
work on the needed VFS changes. Once that process is completed, we
will hopefully just be doing a single current_getucred() per syscall
(and then passing the resulting ucred down to the filesystem layers).

Note: I just updated the original patches with fixed versions that
eliminate a couple of stupid bugs (a couple of automatic
search+replace cases that were screwed). With these fixes, the 2.5.32
kernel boots fine, and appears to be working normally.

Cheers,
  Trond
