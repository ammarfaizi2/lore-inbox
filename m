Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUKKWSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUKKWSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUKKWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:18:40 -0500
Received: from int.cronon.org ([193.254.191.142]:58496 "EHLO cronon.org")
	by vger.kernel.org with ESMTP id S262389AbUKKWSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:18:14 -0500
Date: Thu, 11 Nov 2004 23:09:07 +0100
From: Florian Heinz <heinz@cronon-ag.de>
To: linux-kernel@vger.kernel.org
Subject: a.out issue
Message-ID: <20041111220906.GA1670@dereference.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ppl,

there seems to be a bug related to a.out-binfmt.

try executing this binary:
perl -e'print"\x07\x01".("\x00"x13)."\xc0".("\x00"x16)'>eout
(it may be neccessary to turn memory overcommit on before)

This should result in a kernel-oops.
Doing this in a loop will eat fd's and memory.

seems like find_vma_prepare does not what insert_vm_struct expects when
the whole addresspace is occupied.


