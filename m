Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937162AbWLDSjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937162AbWLDSjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937241AbWLDSjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:39:47 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:51559 "EHLO mail.mnsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937162AbWLDSjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:39:46 -0500
Message-ID: <45746B1B.5060809@mnsu.edu>
Date: Mon, 04 Dec 2006 12:38:19 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Aucoin@houston.rr.com
CC: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dcn@sgi.com
Subject: Re: la la la la ... swappiness
References: <200612041439.kB4EdGFn025092@ms-smtp-03.texas.rr.com> <200612041707.kB4H7Mnh020665@laptop13.inf.utfsm.cl> <20061204100656.793d8d6a.akpm@osdl.org> <Pine.LNX.4.64.0612041012010.32156@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0612041012010.32156@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please forgive me if this is naive.  It seems that you could recompile 
your tar and patch commands to use the POSIX_FADVISE(2) feature with the 
POSIX_FADV_NOREUSE flags.  It seems these would cause the tar and patch 
commands to not clutter the page cache at all.

It'd be nice to be able to make a wrapper out of this kind of like the 
fakeroot(1) command like such as:

nocachesuck tar xvfz kernel.tar.gz

ya know what I mean?

-- 
Jeffrey Hundstad
