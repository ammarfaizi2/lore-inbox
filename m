Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVKVTro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVKVTro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVKVTrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:47:20 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:30623 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965154AbVKVTrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:47:18 -0500
Subject: Re: what is our answer to ZFS?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Adams <cmadams@hiwaay.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051122161712.GA942598@hiwaay.net>
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no>
	 <20051122161712.GA942598@hiwaay.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 20:19:39 +0000
Message-Id: <1132690779.20233.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 10:17 -0600, Chris Adams wrote:
> That assumption is probably made because that's what POSIX and Single
> Unix Specification define: "The st_ino and st_dev fields taken together
> uniquely identify the file within the system."  Don't blame code that
> follows standards for breaking.

It was a nice try but there is a giant gotcha most people forget. Its
only safe to make this assumption while you have all of the
files/directories in question open.

