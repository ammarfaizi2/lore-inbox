Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbULFTbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbULFTbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbULFTbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:31:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21410 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261632AbULFTbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:31:47 -0500
Subject: Re: ip contrack problem, not strictly followed RFC, DoS very much
	possible
From: Lee Revell <rlrevell@joe-job.com>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041206191107.GA7192@localhost>
References: <41B464B3.8020807@pointblue.com.pl>
	 <20041206191107.GA7192@localhost>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 14:31:45 -0500
Message-Id: <1102361505.2897.25.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 20:11 +0100, Jose Luis Domingo Lopez wrote:
> It is not unusual the need to tweak the settings for several commercial
> firewalls I work with in several customers to raise the default timeouts
> for TCP connection tracking, because some application breaks if the
> connection gets put out of the firewalls' connection tables and the
> traffic dropped.
> 
> Many times is just "my users are too lazy to double click the 'start
> connection' icon again when they come from their breakfast, and want to be
> able to enter commands on the remote host again". But at least, the
> parameter is tunable in recent kernel versions, and not hardcoded in the
> kernel sources like it was some time ago.

This is not an application problem.  TCP is a reliable, connection
oriented protocol.  Users are right to expect that their TCP connections
do not get timed out by an overzealous firewall because the user did not
type anything in an SSH window for 20 minutes.

The problem here is that your firewall is too dumb or your firewall
rules too aggressive to distinguish a valid connection from a security
threat.  Please don't blame the users.

Lee

