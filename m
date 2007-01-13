Return-Path: <linux-kernel-owner+w=401wt.eu-S1422715AbXAMQ2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbXAMQ2a (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 11:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbXAMQ2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 11:28:30 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:56057 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422715AbXAMQ2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 11:28:30 -0500
Message-ID: <45A9092F.7060503@student.ltu.se>
Date: Sat, 13 Jan 2007 17:30:39 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] How to (automatically) find the correct maintainer(s)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

Would like to come with a suggestion I have been wondering about for a 
while, why not add the config-flag, used in Kconfig/Makefile in the 
MAINTAINERS-file?

By doing this, there would not be any confusion who to send a patch, 
since all "files" is defined under a flag, right? (when it is a 
header-file, it can be grep'ed on the c-files and from the hit find the 
flag)

So, with a MAINTAINERS-entry like:

SUPERCOOL ALPHA CARD

P:	Clark Kent
M:	superman@krypton.kr
L:	some@thing.com
C:	SUPER_A
S:	Maintained
(C: for CONFIG. Any better idea?)

then if someone changes a file who are built with CONFIG_SUPER_A, can 
easily backtrack it to the correct maintainer(s). And because there is 
no question how to find the correct maintainer, a script can do it for 
us. This is something that would be really useful for Kernel-Janitors 
when doing big cleanups all over the kernel (see ex pci_module_init to 
pci_register_driver and standardize the tree to use macros from 
include/linux/kernel.h).
By this, I believe trivial patch-series would be reduced from the lkml 
when they can automatically be sent to the maintainer (and maybe 
specified mailing-list).

My first idea was to use the pathway and define that directories above 
the specified (if not specified by another) would fall to the current 
maintainer. It would work, but requires that all pathways be specified 
at once, or a few maintainers with "short" pathways would get much of 
the patches (and it is not as correct/easy to maintain as looking for 
the CONFIG_flag).


Any thoughts on this is very much appreciated (is there any flaws with 
this?).

Richard Knutsson

