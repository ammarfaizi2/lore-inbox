Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUKVO6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUKVO6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUKVO5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:57:20 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:39557 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261451AbUKVOy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:54:26 -0500
Message-ID: <41A1FDA0.1070204@ens-lyon.fr>
Date: Mon, 22 Nov 2004 15:54:24 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kmap_atomic
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to know if I can use kmap_atomic with KM_USER[01] type
within a non-interrupt context. Looking at comments near kmap_atomic
declarations on sparc or ppc, it seems that this is discouraged.

But lots of code (like filesystem stuff) are currently using it
outside of interrupt context.
Are there special requirements about KM_USER[01] usage in interrupt
or non-interrupt contexts ?
Is it documented somewhere how we can use it ?

What I want to do is just kmap_atomic, copy and kunmap_atomic.

Regards,
-- 
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
France
