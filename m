Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755608AbWKVK30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbWKVK30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbWKVK30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:29:26 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:31922 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1755608AbWKVK3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:29:25 -0500
Date: Wed, 22 Nov 2006 11:27:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: James Hunt <james@jameshunt.org.uk>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com
Subject: Re: [PATCH 1/3] ext2/3/4: enable "undeletable" file attribute.
In-Reply-To: <20061121221632.GA12422@localdomain>
Message-ID: <Pine.LNX.4.61.0611221127160.15991@yvahk01.tjqt.qr>
References: <20061121221632.GA12422@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Currently, although you can mark a file as undeletable with 'chattr'...
>
>  > touch /tmp/wibble
>  > ls -l /tmp/wibble
>  -rw-rw-r-- 1 james james 0 Nov 16 20:00 /tmp/wibble
>  > chattr +u /tmp/wibble      # mark file as undeletable
>  > lsattr /tmp/wibble
>  -u----------- /tmp/wibble
>
>... it's not honoured by the kernel:
>
>  > rm /tmp/wibble             # yikes! this should fail!!

Currently, the immutable flag controls the behavior to forbid deletion.


	-`J'
-- 
