Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTHVREv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264195AbTHVREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:04:51 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:10629
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263698AbTHVREr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:04:47 -0400
Message-ID: <3F464CE4.8040704@redhat.com>
Date: Fri, 22 Aug 2003 10:03:32 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>, kuznet@ms2.inr.ac.ru,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow either tid or pid in SCM_CREDENTIALS struct ucred
References: <1061451559.4386.13.camel@localhost.localdomain>
In-Reply-To: <1061451559.4386.13.camel@localhost.localdomain>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy Fitzhardinge wrote:

> This patch also makes it accept tgid in the SCM_CREDENTIALS pid field. 
> That is, a threaded program can either supply the ID of the whole
> process (tgid) or a particular thread (pid).  

I don't think ->pid should be tested.  Just replace it with ->tgid.
It's really not intended for the user to have any contact with the TID
(i.e., ->pid).  This is how it's done in other place.  What this shows
is that more searches for ->pid are needed which need to be replaced
with ->tgid.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Rkzk2ijCOnn/RHQRAi7PAKCT+l2NCmoDzpHgq/yqFcqXmBArKQCgkxzW
wy2BYybK6yXrJRpNd6957tA=
=IW8f
-----END PGP SIGNATURE-----

