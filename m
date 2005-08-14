Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVHNMEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVHNMEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVHNMEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:04:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1178 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932494AbVHNMEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:04:34 -0400
Date: Sun, 14 Aug 2005 06:56:51 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BSD jail
Message-ID: <20050814115651.GA6024@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <bda6d13a050812174768154ea5@mail.gmail.com> <20050813143335.GA5044@IBM-BWN8ZTBWA01.austin.ibm.com> <bda6d13a0508130933bdbc46a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0508130933bdbc46a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joshua Hudson (joshudson@gmail.com):
> Why would you want a virtual network device implementation? The whole

So that a jailed process can use the net but can't use your network
address (intercept ssh, imap/stunnel, etc).

> I do like the idea of patching in through LSM, however not everything
> can be done there.
> In particular, I could escape from the jail as implemented there by a
> classic chroot()
> trick.

As Alan Cox had noted,  you can escape with the help of an outside
process, but the classic chroot(TEMPDIR);chdir(..);...;chroot(.)
did not work against either the namespace-based or certainly not the
older (inode_permission-based) implementation.

But in the end vserver with read-only bind mounts seems a better way to
go imo.

-serge

