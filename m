Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWGLRT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWGLRT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGLRT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:19:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:21373 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932125AbWGLRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:19:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=rgWooAGRPnRSEi4pyOdc+bpQ2EpK/FB5rgcg/5h1FxGY7CexwFREufeB/FGDSOjBsnrcf1MXWyjddzUefOZPTDl7On24YgKyzjDn3p6o+H8/yxfiur9UkV3W3Kff2piZMJJnEQQWBZcLJVBtPg/IqHmf6LsMtul6wkKXukGhN/o=
Message-ID: <44B52F25.6010109@gmail.com>
Date: Wed, 12 Jul 2006 11:19:33 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ patch -mm1 00/03 ] gpio: 3 minor tweaks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patchset does:

1 - drops gpio_set_high, gpio_set_low from the nsc_gpio_ops vtable.
While we can't drop them from scx200_gpio (or can we ?),  vtable users
(ie new users) dont need them, they can just use gpio_set()

2 - pure cosmetics - lose needless newlines.

3 - rename EXPORTed  gpio vtables  from {scx200,pc8736x}_access to  
_gpio_ops
new name is much closer to the vtable-name struct nsc_gpio_ops, and 
should be clearer.
Also rename the _fops vtable vars to _fileops to better disambiguate it 
from the gpio vtables.


