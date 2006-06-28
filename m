Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932803AbWF1NmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbWF1NmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWF1NmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:42:07 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:37853 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S932803AbWF1NmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:42:06 -0400
Message-ID: <44A28646.4020408@draigBrady.com>
Date: Wed, 28 Jun 2006 14:38:14 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Paulson <epaulson@cs.wisc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: file changes without updating mtime
References: <20060627181010.GE25040@cobalt.cs.wisc.edu>
In-Reply-To: <20060627181010.GE25040@cobalt.cs.wisc.edu>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps you could create a filesystem wrapper module
or Linux Security module or equivalent to intercept write/truncate etc.
to invalidate an extended attribute containing a checksum.

This extended attribute could be updated from userspace periodically,
and your userspace program would compare those checksums.

That would be generally useful. For example rsync could
use it to very quickly determine if it needed to sync file contents.

See also http://lkml.org/lkml/2006/5/17/138

Note also files mounted loopback and modified don't
have their mtime updated either. Perhaps the patch
referenced above addresses that?

Pádraig.
