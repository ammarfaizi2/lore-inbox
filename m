Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423586AbWJaQts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423586AbWJaQts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423588AbWJaQts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:49:48 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:6341 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1423586AbWJaQtr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:49:47 -0500
Message-ID: <45477EA8.8060809@gmail.com>
Date: Tue, 31 Oct 2006 17:49:44 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Guillermo Marcus <marcus@ti.uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de> <4547733B.9040801@gmail.com> <45477912.7070903@ti.uni-mannheim.de>
In-Reply-To: <45477912.7070903@ti.uni-mannheim.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo Marcus wrote:
> Hi Jiri,
> 
> The fact that it does not works with RAM is well documented in LDD3,
> pages 430++. It says (and I tested) that remap_xxx_range does not work
> in this case. They suggest a method using nopage, similar to the one I
> implement.

Could somebody confirm, that this still holds?

> I do not see why remap_xxx_range has the limitation, but it is there.
> The question is then: can the limitation be removed, or can we implement
> a new function that maps RAM all at once without the need for a nopage
> implementation?
> 
> In any case, here is the code.

Hmm, interesting. I used remap_pfn_range for this purpose today and it worked (I
double-checked this). I should probably do the rework :(.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
