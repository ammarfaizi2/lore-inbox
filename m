Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbULaDdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbULaDdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 22:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbULaDdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 22:33:18 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:51346 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261815AbULaDdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 22:33:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=hNH4QW9DpRgi3CG9cqcAlNkJkGhMsiH5mscFSZGP9t21rh1gMLLQkG4ExiD33AZjkeaEoXLWwg/c/kgzfu+VEcITPkLeAxOtye4VNQWpdWxiz3TNPfIhRgaWQACJqkz3DQzYWCnCFPvmgxZQ48NoUzyV/LJEj+s5WSKxp7SxzCY=
Message-ID: <169c13c404123019322a766f64@mail.gmail.com>
Date: Fri, 31 Dec 2004 04:32:59 +0100
From: Felipe Erias <charles.swann@gmail.com>
Reply-To: Felipe Erias <charles.swann@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Queues when accessing disks
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to apply queuing theory to the study of the GNU/Linux kernel.
Right now, I'm focusing in the queue of processes that appears when they
try to access an I/O device (specifically, an IDE HD). When they want to
read data, it behaves as a usual queue: several clients (processes) that
require attention from a server (disk / driver / ...). The case when they want
to write data is a bit more tricky, because of the cache buffers used by the OS,
and maybe could be modelized by a network of queues. Both cases are
interesting for my work, but I'll take the reading one first, just
because it seems
a bit more simple 'a priori'.

To modelize the queue, I need to get some information:
 - what processes claim attention from the disk
 - when they do it
 - when they begin to be served
 - when they finish being served

To get all this information, maybe I could hack my kernel a bit to write
a line to a log on every access to the HD, or account the IRQs from
the IDE channels... I also have the feeling that this queuing problem could
dissappear o became more hidden if DMA were enabled.

To be true, I'm a bit lost and that's why I ask for your help.

Yours sincerely,

  Felipe Erias
