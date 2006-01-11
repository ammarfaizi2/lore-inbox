Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWAKNqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWAKNqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWAKNqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:46:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:16050 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751582AbWAKNqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:46:35 -0500
Subject: Re: ata errors -> read-only root partition. Hardware issue?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f60601110030u358c12fcscf79067cbc3eebe0@mail.gmail.com>
References: <5ttip-Xh-13@gated-at.bofh.it> <43C4493A.4010305@shaw.ca>
	 <5a2cf1f60601110030u358c12fcscf79067cbc3eebe0@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Jan 2006 13:38:08 +0000
Message-Id: <1136986688.28616.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-11 at 09:30 +0100, jerome lacoste wrote:
> - scan for bad blocks

Read the entire disk (write will hide and clean up errors by
reallocating)

> - maybe check the SMART results if they are available

Definitely - failures are in the smart log

> - memory check: memtest86 & memtest86+ tests (just in case)

memory failures generally show a different pattern, you get corruption
not errors off disks.

Alan

