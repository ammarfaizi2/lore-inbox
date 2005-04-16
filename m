Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVDPB1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVDPB1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVDPB1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:27:37 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:14863 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262548AbVDPB1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:27:19 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sat, 16 Apr 2005 01:25:19 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3pphv$4m5$2@abraham.cs.berkeley.edu>
References: <20050414141538.3651.qmail@science.horizon.com> <20050414133336.GA16977@thunk.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113614719 4805 128.32.168.222 (16 Apr 2005 01:25:19 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Apr 2005 01:25:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o  wrote:
>With a properly set up set of init scripts, /dev/random is initialized
>with seed material for all but the initial boot [...]

I'm not so sure.  Someone posted on this mailing list several months
ago examples of code in the kernel that looks like it could run before
those init scripts are run, and that looks like it might well be using
/dev/*random before it has been seeded.

I never saw any response.

>It fundamentally assumes that crypto
>primitives are secure (when the recent break of MD4, MD5, and now SHA1
>should have been a warning that this is a Bad Idea (tm)),

It looks to me like the recent attacks on MD4, MD5, and SHA1 do not
endanger /dev/random.  Those attacks affect collision-resistance, but
it looks to me like the security of /dev/random relies on other properties
of the hash function (e.g., pseudorandomness, onewayness) which do not
seem to be threatened by these attacks.  But of course this is a complicated
business, and maybe I overlooked something about the way /dev/random uses
those hash functions.  Did I miss something?

As for which threat models are realistic, I consider it more likely
that my box will be hacked in a way that affects /dev/random than that
SHA1 will be broken in a way that affects /dev/random.

>In addition, Fortuna is profligate with entropy, [...]

Yup.
