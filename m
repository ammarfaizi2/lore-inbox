Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUHSJAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUHSJAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUHSJAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:00:09 -0400
Received: from mail1.kontent.de ([81.88.34.36]:24262 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264213AbUHSI5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:57:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: PF_MEMALLOC in 2.6
Date: Thu, 19 Aug 2004 10:59:02 +0200
User-Agent: KMail/1.6.2
Cc: arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
References: <20040818235523.383737cd@lembas.zaitcev.lan>
In-Reply-To: <20040818235523.383737cd@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191059.02628.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. August 2004 08:55 schrieb Pete Zaitcev:
> The PF_MEMALLOC is required on usb-storage threads in 2.4, because ext3
> will deadlock and otherwise misbehave when it's trying to write out
> dirty pages under memory pressure.

Can you tell where it hangs? 2.6 passes GFP_NOIO around. If we
have an error about that somewhere we need to find it because
it may also affect the error handlers which do not operate in that
context.

	Regards
		Oliver
