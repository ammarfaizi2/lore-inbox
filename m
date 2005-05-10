Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVEJPNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVEJPNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVEJPNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:13:07 -0400
Received: from schlund.terranet.ro ([80.96.218.84]:9020 "EHLO
	dizzywork.schlund.ro") by vger.kernel.org with ESMTP
	id S261670AbVEJPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:12:48 -0400
Message-ID: <4280CF60.7080803@schlund.ro>
Date: Tue, 10 May 2005 18:12:32 +0300
From: Mihai Rusu <dizzy@schlund.ro>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rml@novell.com
Subject: [RFC][PATCH 2.4 0/4] inotify 0.22 2.4.x backport
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This are the patches for 2.4.x inotify 0.22 backport. While probably
there is no chance to have this included in vanilla 2.4.x I hope there
are interested people that can test it out. Any feedback is very
appreciated.

The modifications have been worked out on 2.4.27 (the kernel versions we
 need/use right now) and adapted for 2.4.30 to apply cleanly. We
performed our testing with usermode linux and UML (virtual) SMP feature.

While developing/working on it at some point we observed a "create file"
event not being generated for a new file. This only happened once and we
were unable to reproduce this so far. So be careful :)

Also because of the x86 only atomic_inc_return backport the codes
currently only compile for x86. It should be easy however to backport
those codes for other architectures.

The following patches will be:
- find_next_bit backport
- idr backport
- atomic_inc_return x86 backport
- inotify specific codes backport

-- 
Mihai Rusu
Linux System Development

Schlund + Partner AG   Tel         : +40-21-231-2544
Str Mircea Eliade 18   EMail       : dizzy@schlund.ro
Sect 1, Bucuresti
71295, Romania

