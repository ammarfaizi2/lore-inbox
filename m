Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWH2MXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWH2MXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWH2MXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:23:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751343AbWH2MXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:23:23 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829115138.GA32714@infradead.org> 
References: <20060829115138.GA32714@infradead.org>  <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 13:23:18 +0100
Message-ID: <15945.1156854198@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Same as above.  USB_STORAGE already selects scsi so it shouldn't need
> to depend on block.

Ah, you've got it the wrong way round.

Because USB_STORAGE _selects_ SCSI rather than depending on it, even if SCSI
is disabled, USB_STORAGE can be enabled, and that turns on CONFIG_SCSI, even
if not all of its dependencies are available.

Run "make allyesconfig" and then try to turn off CONFIG_SCSI without this...

David
