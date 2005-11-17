Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVKQWIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVKQWIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVKQWIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:08:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56015 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932282AbVKQWIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:08:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <25039.1132150357@warthog.cambridge.redhat.com> 
References: <25039.1132150357@warthog.cambridge.redhat.com> 
To: Alexander Zangerl <az@bond.edu.au>
Cc: torvalds@osdl.org, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Permit key expiry time to be set 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 17 Nov 2005 22:08:06 +0000
Message-ID: <8585.1132265286@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've stuck an updated keyutils tarball and SRPM on:

	http://people.redhat.com/~dhowells/keyutils/keyutils-0.3-2.tar.bz2 
	http://people.redhat.com/~dhowells/keyutils/keyutils-0.3-2.src.rpm

For those who want to play with the new facilities.


Alexander Zangerl: I've incorporated my take on your patch by which
/sbin/request-key can be made to dangle a slave program at the ends of a pair
of pipes to do the work. The callout_info is passed to stdin and the payload
data retrieved via stdout. You configure it by sticking a '|' symbol in front
of the program name in /etc/request-key.conf. Can you test it please. That bit
compiles, but I haven't had time to test it yet, so it may not work.

David
