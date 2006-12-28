Return-Path: <linux-kernel-owner+w=401wt.eu-S964975AbWL1Vw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWL1Vw1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWL1Vw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:52:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:52858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964975AbWL1Vw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:52:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=UXhY6URRxPhReeJWMJG2304dvu7ALmtUo94LMNTtIPc4WlN076EozQAaybVyJrZ9it8lf7NIfUGUhsdcideY45IcSeaeNqRi/q9RsRKXrnSfLVp2WLt0Y9aEFwD0naMEq3UFWA6RoFF39P/0C784Z11yJtY4YuX9oARU9EdSWh0=
Message-ID: <727e50150612281352m524cc325gc8695b9c5087aade@mail.gmail.com>
Date: Thu, 28 Dec 2006 16:52:24 -0500
From: "Aaron Cohen" <aaron@assonance.org>
To: "LKML List" <linux-kernel@vger.kernel.org>
Subject: CAP_LINUX_IMMUTABLE question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 09c2465128cd4dfc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CAP_LINUX_IMMUTABLE currently makes it impossible both to chattr +i or
chattr -i.

I think it would be convenient if there was someone to make it only
illegal for chattr -i.  So that I could still make files unchangeable,
while not allowing myself to ever make them changeable again without
the capability.

I'm currently using CAP_LINUX_IMMUTABLE (along with CAP_SYS_RAWIO and
CAP_SYS_MODULE) to make a poor-man's readonly bootable USB key for USB
drives that don't have a physical R/W switch.  (The priviledges are
dropped in my initscripts).

The only problem is that such a USB key isn't able to make a copy of
itself because it can't remove the mutability of files which is a
little inconvenient. :)

I doubt it would be possible to change the semantics for
CAP_LINUX_IMMUTABLE but would it be stupid of me to try to add a
CAP_LINUX_MUTABLE flag that does what I want?

Thanks,
Aaron
