Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTKYAIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTKYAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:08:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6150 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261836AbTKYAIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:08:40 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: hard links create local DoS vulnerability and security problems
Date: 24 Nov 2003 23:57:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bpu5tp$vvd$1@gatekeeper.tmr.com>
References: <20031124180838.GA8065@sigint.cs.purdue.edu> <Pine.LNX.4.53.0311241312180.18685@chaos>
X-Trace: gatekeeper.tmr.com 1069718265 32749 192.168.12.62 (24 Nov 2003 23:57:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0311241312180.18685@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
| On Mon, 24 Nov 2003 splite@purdue.edu wrote:
| 
| > On Mon, Nov 24, 2003 at 06:57:41PM +0100, Jakob Lell wrote:
| > > [...]
| > > Setuid-root binaries also work in a home directory.
| > > You can try it by doing this test:
| > > ln /bin/ping $HOME/ping
| > > $HOME/ping localhost
| > > [...]
| >
| > That's why you don't put user-writable directories on the root or /usr
| > partitions.  (For extra points, mount your /tmp and /var/tmp partitions
| > nodev,nosuid.)  Seriously guys, this is Unix Admin 101, not a major new
| > security problem.
| >
| 
| And if the inode that was referenced in the root-owned directory
| was deleted, it would no longer function as setuid root.

??? think about how the inode is deleted... by removing all links.
Clearly if there is another link the inode can't be deleted, and if the
inode is deleted whatever you meant by "it" would function or even exist
(both the link and the inode would be gone).
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
