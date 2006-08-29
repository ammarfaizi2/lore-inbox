Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWH2Sxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWH2Sxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWH2Sxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:53:44 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:58796
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S965250AbWH2Sxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:53:43 -0400
From: Michael Buesch <mb@bu3sch.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6]
Date: Tue, 29 Aug 2006 20:53:09 +0200
User-Agent: KMail/1.9.1
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com> <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608292053.09550.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 20:06, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> This makes CONFIG_USB_STORAGE depend on CONFIG_SCSI rather than selecting it,
> as selecting it makes CONFIG_USB_STORAGE override the dependencies of SCSI,
> causing it to turn on even if they aren't all met.

Isn't this a kbuild bug, if that really happens? Shouldn't
CONFIG_USB_STORAGE be invisible, if a SELECTed has dependencies that
we are not able to SELECT, too?

-- 
Greetings Michael.
