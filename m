Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273022AbTG3Q6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273025AbTG3Q6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:58:12 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:11795 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S273022AbTG3Q6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:58:09 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
In-Reply-To: <20030730135623.GA1873@lug-owl.de>
References: <20030730135623.GA1873@lug-owl.de>
Message-Id: <E19huHB-0000Or-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Wed, 30 Jul 2003 17:58:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:

>Please apply. Worst to say, even Debian seems to start using i486+
>features (ie. libstdc++5 is SIGILLed on Am386 because there's no
>"lock" insn available)...

g++ >=3.2 use 486-specific instructions in order to do atomic operations
in C++ code. 3.3 includes a 386 version of the same code, but it's not
possible to use a mixture of the two (ie, code compiled with a "486" g++
will not work on the "386" version), and so to keep ABI compatibility
with the other distributions it's necessary to break 386. The "obvious"
solution (dragging this back on topic) is a kernel patch to emulate 486
instructions on a 386.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
