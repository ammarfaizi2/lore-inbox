Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271220AbTGWS6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271219AbTGWS5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:57:25 -0400
Received: from H-135-207-24-32.research.att.com ([135.207.24.32]:64139 "EHLO
	mailman.research.att.com") by vger.kernel.org with ESMTP
	id S271220AbTGWS4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:56:53 -0400
Date: Wed, 23 Jul 2003 15:11:47 -0400 (EDT)
From: Glenn Fowler <gsf@research.att.com>
Message-Id: <200307231911.PAA35164@raptor.research.att.com>
Organization: AT&T Labs Research
X-Mailer: mailx (AT&T/BSD) 9.9 2003-01-17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
References: <200307231428.KAA15254@raptor.research.att.com>  <20030723074615.25eea776.davem@redhat.com>  <200307231656.MAA69129@raptor.research.att.com>  <20030723100043.18d5b025.davem@redhat.com>  <200307231724.NAA90957@raptor.research.att.com>  <20030723103135.3eac4cd2.davem@redhat.com>  <200307231814.OAA74344@raptor.research.att.com>  <20030723112307.5b8ae55c.davem@redhat.com>  <200307231854.OAA90112@raptor.research.att.com> <20030723120457.206dc02d.davem@redhat.com>
To: davem@redhat.com, gsf@research.att.com
Subject: Re: kernel bug in socketpair()
Cc: dgk@research.att.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jul 2003 12:04:57 -0700 David S. Miller wrote:
> Is bash totally broken because of all this?  Or does the problem only
> trigger when using (cmd) subprocesses in a certain way?

bash uses pipe() so its ok
using socketpair() instead of pipe() introduces the problem
and we will now have to find an alternative to work around the
linux /dev/fd/N implementation

thanks

