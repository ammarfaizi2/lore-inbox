Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUKRSaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUKRSaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbUKRSaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:30:09 -0500
Received: from dsl-213-023-011-165.arcor-ip.net ([213.23.11.165]:13322 "EHLO
	be3.lrz.7eggert.dyndns.org") by vger.kernel.org with ESMTP
	id S262837AbUKRS15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:27:57 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] WTF is VLI?
To: Avi Kivity <avi@argo.co.il>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@nurfuerspam.de
Date: Thu, 18 Nov 2004 19:28:21 +0100
References: <fa.inbtt12.195ed02@ifi.uio.no> <fa.cg6f09j.ji89hv@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1CUr14-0000oQ-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:

> for (offset = 0; offset < max_instr_len; ++offset) {
>     create_object_file(code + offset, len - offset);
>     disassemble();
>     if (disassembly_includes_eip())


Will fail for

movl eax,cc000000 ;or something similar, you get the point
*EIP here*

and result in

INT3
-- 
Keep your hands off strong drink. It can make you shoot at the tax collector
and miss.
        -- R.A. Heinlein
Friﬂ, Spammer: snapdragon4709@qytayz.com fBzlGY9EVuwDME1@disrxcount.com
