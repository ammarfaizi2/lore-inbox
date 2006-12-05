Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937471AbWLEHiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937471AbWLEHiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 02:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937472AbWLEHiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 02:38:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:16783 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937471AbWLEHiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 02:38:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K78/7OmpsAxQQagVes1gMy9RABqCK755AyCdRAa2kk4z0KG3kfFPcOv3EYsgVNkqGq/+x+j28U8CH2hhl+PNGJfalzdFvkTyt01T95DFVgzzLwk1K293dLt6C4IzR8/4Vei4ykcHiEoyzw1vynuYiFgsE9UN2+psVd7ZH/5Ln5M=
Message-ID: <f383264b0612042338y2609dd76w8ba562394800bbd0@mail.gmail.com>
Date: Mon, 4 Dec 2006 23:38:13 -0800
From: "Matt Reimer" <mattjreimer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In light of James Bottomsley's commit[1] declaring that kmap() and
friends now have to take care of coherency issues, is the patch "mm:
D-cache aliasing issue in cow_user_page"[2] correct, or could it
potentially cause a slowdown by calling flush_dcache_page() a second
time (i.e. once in an architecture-specific kmap() implementation, and
once in cow_user_page())?

Matt

[1] http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a6ca1b99ed434f3fb41bbed647ed36c0420501e5
[2] http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c4ec7b0de4bc18ccb4380de638550984d9a65c25
