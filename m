Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbWJDPw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWJDPw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbWJDPw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:52:26 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:18819 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1161259AbWJDPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:52:25 -0400
Date: Wed, 04 Oct 2006 11:51:55 -0400
From: Eric Buddington <ebuddington@verizon.net>
Subject: 2.6.18-mm1: true/false enum in linux/stddef.h fails glibc-2.4 compile
To: linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20061004155155.GD17660@pool-71-123-69-209.wma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an enum contained in some recent -mm versions of
linux/stddef.h which seems to be horking my glibc-2.4 compile:

enum {
        false   = 0,
        true    = 1
};

One way or another (I can't find where), 'true' and 'false' are
getting defined to 1 and 0, turning the above into enum { 0=0, 1=1 },
which though undeniable is not compilable.

This enum shows up in 2.6.18-rc5-mm1 and 2.6.18-mm1, but not in
2.6.17-mm6.

Whether this is the fault of glibc, gcc, or the kernel is a topic I
wouldn't touch with a 3m pole, even if I had one. I've submitted the
issue to the glibc bugzilla as well:

http://sources.redhat.com/bugzilla/show_bug.cgi?id=3301

Any thoughts would be appreciated.

Thanks,

Eric
