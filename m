Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbTGBJiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTGBJiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:38:23 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:65486 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S264890AbTGBJiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:38:13 -0400
Subject: build from RO source tree?
From: david nicol <whatever@davidnicol.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057139553.5088.20.camel@plaza.davidnicol.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jul 2003 04:52:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a make option for building from a read-only kernel source,
possibly by doing a pre-pass to create a mess of symlinks?

Something like

	(chdir $readonly_sourceroot && find . -type d ) \
	| xargs -n5 mkdir
	(chdir $readonly_sourceroot && find . -type f ) \
	| xargs -i ln -s $readonly_sourceroot/{} {}
	make


but as a configure option of some kind.









-- 
David Nicol, independent consultant, contractor, and food service worker

