Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTFYVLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFYVLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:11:47 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:39309 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265080AbTFYVLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:11:44 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "J.C. Wren" <jcwren@jcwren.com>
Date: Wed, 25 Jun 2003 23:25:35 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Assorted warnings while building 2.5.73
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <57481010E50@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jun 03 at 16:25, J.C. Wren wrote:
> drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
> drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
> drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'

Fix min/max macros and/or learn gcc that "const typeof(x)" where x
is already const type is OK. Or I can code it with simple if(), but
why we have min/max macros then?

Is there some __attribute__((-Wno-duplicate-const)) ?
                                         Petr Vandrovec
                                         vandrove@vc.cvut.cz
                                         

