Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTICOcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTICOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:32:04 -0400
Received: from ool-4353cae3.dyn.optonline.net ([67.83.202.227]:51620 "EHLO
	bigip.bigip.mine.nu") by vger.kernel.org with ESMTP id S262353AbTICOb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:31:59 -0400
Date: Wed, 3 Sep 2003 10:31:57 -0400
From: Mathieu Chouquet-Stringer <mchouque@online.fr>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Compiling latest 2.6 bk snapshot on Alpha
Message-ID: <20030903143157.GA17699@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@online.fr>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	  Hi all,

I've been hitting the same error every time I try to compile bk current on
alpha, namely the linker can't do its job on .tmp_vmlinux1.
My compiler is "gcc version 3.2.3 (Debian)" (but I also tried with 3.3 and
2.95), same problem.

Here is the output:
  LD      .tmp_vmlinux1
init/built-in.o(.text+0x12a8): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x137c): In function `inflate_codes':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x15bc): In function `inflate_stored':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x2158): In function `inflate':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x2170): In function `inflate':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x21b4): In function `inflate':
: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0x21d4): In function `inflate':
: relocation truncated to fit: BRADDR .init.text
make: *** [.tmp_vmlinux1] Error 1

Am I missing something? Is there a bk tree for Alpha (Jeff Garzik, in his
bk doc talks about one but it seems to be dead)?

-- 
Mathieu Chouquet-Stringer              E-Mail : mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
