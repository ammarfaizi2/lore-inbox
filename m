Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTEMRZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTEMRZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:25:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12446
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262268AbTEMRZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:25:03 -0400
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
In-Reply-To: <Pine.LNX.4.44.0305130950030.1678-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305130950030.1678-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052843954.431.84.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 17:39:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 17:57, Linus Torvalds wrote:
> A "user" is by definition what the unix filesystem considers to be the
> "atom of security". In fact, a "user" has no other meaning - except for
> the notion of "root", which is obviously special and has meaning outside
> of the scope of filesystems (and even here capabilities have tried to
> separate out that meaning from the "user" definition).

This has been untrue since the security hooks went in, and in some
senses before that (capabilities mean multiple "root"'s)

> "role" that is shared across processes. But I think that for _usability_
> we really want that to be _shared_ by default, and anybody who wants to
> split it should have to work at it. Exactly so that when you log in, and
> use your private key to mount some encrypted volume, _all_ your processes
> should by default get access to it. Even if the other ones were
> independent logins (another window with another ssh session to that
> machine).
> 
> In other words: I really think usability should count very high on the 
> list of requirements. Much higher than SELinux.

Sounds right. PAM can certainly do the splitting providing the functionality
is there to do it

