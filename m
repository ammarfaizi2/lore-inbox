Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbUKKBUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUKKBUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUKKBUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:20:44 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20418 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262048AbUKKBUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:20:38 -0500
Subject: Broken kunmap calls in rc4-mm1.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1100135825.7402.32.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 11 Nov 2004 12:17:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew et al.

That oops in kunmap got me thinking of my recent DEBUG_HIGHMEM
additions, so I want for a walk through the -mm4 patch, and found plenty
of instances of people making the same mistake I did... using the struct
page * in the call to kunmap, rather than the virtual address.

I guess the best way to handle it is find/notify the respective authors
of patches in the tree? The problems are in:

Reiser4 (lots)
CacheFS (lots)
afs
binfmt_elf
libata_core

(I'm hoping some of the above people will see this message and save me
some effort :>)

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

