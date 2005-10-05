Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVJEUko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVJEUko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJEUko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:40:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55248 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750809AbVJEUkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:40:43 -0400
Date: Wed, 5 Oct 2005 16:40:35 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: PAE causing failure to run various executables.
Message-ID: <20051005204035.GB10640@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A fedora user recently filed a puzzling bug at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=169741

The system being reported has exactly 4GB, and its E820
tables seem to concur that there is in fact 4GB.

When run in non-PAE mode, it triggers the
"Warning only 4GB will be used. Use a PAE enabled kernel."
message, which is odd, but the system does actually run.

When run in PAE mode, it seems to lose its mind, and it
fails to run various binaries.

Booting with mem=4G causes the machine to boot fine
(though for some reason, it finds only 3042M of RAM).


The reporter of this bug has tested on 2.6.14-rc3-git4, and found the
same issue exists as he saw on the original FC3 kernel, thus ruling out
any Fedora-specific patches.

Anyone have any ideas what's wrong here?

		Dave

