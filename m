Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUG2AkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUG2AkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUG2AkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:40:21 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:28618 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267376AbUG2Ajs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:39:48 -0400
From: David Brownell <david-b@pacbell.net>
To: pavel@suse.cz
Subject: Re: device_suspend() levels
Date: Wed, 21 Jul 2004 05:10:21 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407210510.21694.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See http://bugme.osdl.org/show_bug.cgi?id=2886 which includes
a partial patch.

This is the same problem that's been biting USB.  Any PCI driver that
actually tries to use the PCI state passed into its suspend() code is
going to be broken because of this "ACPI != PCI" issue.

- Dave
