Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTDGIWC (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTDGIWC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:22:02 -0400
Received: from smtpde02.sap-ag.de ([155.56.68.170]:1420 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP id S263325AbTDGIWB (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:22:01 -0400
From: Christoph Rohland <cr@sap.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       CaT <cat@zip.com.au>, <tomlins@cam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Organisation: Development SAP J2EE Engine
Date: Mon, 07 Apr 2003 10:32:58 +0200
In-Reply-To: <Pine.LNX.4.44.0304022201010.3034-100000@localhost.localdomain> (Hugh
 Dickins's message of "Wed, 2 Apr 2003 22:04:10 +0100 (BST)")
Message-ID: <ov65pqlnb9.fsf@sap.com>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Native Windows TTY
 Support (Windows), cygwin32)
References: <Pine.LNX.4.44.0304022201010.3034-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Wed, 2 Apr 2003, Hugh Dickins wrote:
> Don't blame Christoph for that, one of these days I'll face up to
> my responsibilities and make swapoff fail (probably get itself
> OOM-killed) instead of having everything else OOM-killed.

The hooks for the accounting would solve this easily: the swapoff hook
would realize that there is not enough space left for the tmpfs
instance and simply return an error. So swapoff would fail.
We would not even stress the vm to swapin all pages until
realizingthat there is not enough memory left.

Greetings
		Christoph


