Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUK3AbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUK3AbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUK3AbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:31:23 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:2210 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261887AbUK3AbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:31:05 -0500
Date: Tue, 30 Nov 2004 09:31:03 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: Re: [lkdump-develop] Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
Message-Id: <20041130083116.3D92.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a developer of an yet another crash dump (mkdump). 
I'd like to know conditions which cause taking dump fail.
It is helpful to share those informations for dump developers.

I have three major concerns about taking dump.
* interrupt disable
  taking dump should be run under interrput disable.
  diskdump is aware of that. How about kexec based dump ?
* avoid deadlock
  taking dump should not get any locks to avoid deadlock. (?)
  I think there are many posibility of deadlock in the kexec
  based dump (from crash occur to initiate the new kernel).
  (mkdump does not meet neither yet. :-p)
* be sure to get the other CPUs' register value
  How are the other CPUs' regsiter value get and how are the 
  other CPUs stoped ?
(of course the goal of mkdump is to solve these points 
 although not implemented yet :-)

Any other points to be consider ?
Comments and suggestions are welcome.

Thank you.
-- 
Itsuro ODA <oda@valinux.co.jp>

