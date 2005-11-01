Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVKAHh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVKAHh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVKAHh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:37:28 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:41231 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932400AbVKAHh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:37:27 -0500
To: rob@landley.net
CC: linuxram@us.ibm.com, greg@enjellic.com, mikew@google.com,
       linux-kernel@vger.kernel.org, leimy2k@gmail.com
In-reply-to: <200510311727.27145.rob@landley.net> (message from Rob Landley on
	Mon, 31 Oct 2005 17:27:26 -0600)
Subject: Re: /etc/mtab and per-process namespaces
References: <200510221323.j9MDNimA009898@wind.enjellic.com> <200510290516.37700.rob@landley.net> <1130785899.4773.19.camel@localhost> <200510311727.27145.rob@landley.net>
Message-Id: <E1EWqgc-0006AY-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 01 Nov 2005 08:36:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (Then, of course, there's FUSE.  Does killing the FUSE helper
> prevent the mount from being umounted?)

No.  On clean exit (via INT, TERM, HUP handlers installed by library)
it will lazy umount itself.  Violent death of a filesystem daemon will
leave the mount intact, but umountable.

Miklos
