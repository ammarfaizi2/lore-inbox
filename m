Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWBMXDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWBMXDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWBMXDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:03:32 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:64379 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030254AbWBMXDb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:03:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QwspeUEg5Z/fELOMzaeehazIwf2W/0RHoqvZQnx2hQxQ5uR9yQA/zPgfiVjXISoqGb5QVlV8Bi4UxjU3si7Do7MM5uTExXfhaW6xlGB3iAJM2nRa8zJ6KoY18OYet1ayQtMj3Ixsu8z8mVjiolHexoPZM293RQWN+MA5qohzLnw=
Message-ID: <bda6d13a0602131503n14650120gaa39eda9a38aefbf@mail.gmail.com>
Date: Mon, 13 Feb 2006 15:03:26 -0800
From: Joshua Hudson <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sb_bread & bforget
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New filesystem is using BTrees for directories. An update will touch
multiple blocks, loaded into buffer_head structures with sb_bread.

If update fails (only possible causes are read error & disk full), is it
kosher to call bforget on all modified buffer_head structures, or
does that have some unintended consequences?
