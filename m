Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280835AbRKGQBb>; Wed, 7 Nov 2001 11:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280829AbRKGQBU>; Wed, 7 Nov 2001 11:01:20 -0500
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:62845 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280828AbRKGQBI>; Wed, 7 Nov 2001 11:01:08 -0500
Message-ID: <3BE95AB4.96C1D729@mandrakesoft.com>
Date: Wed, 07 Nov 2001 11:00:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: quintela@mandrakesoft.com, sbenedict@mandrakesoft.com
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: alpha and PPC broken by latest kernel RPM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan,

In the latest kernel RPM, you disable entries without even checking to
see if they exist on PPC or Alpha.  This breaks the kernel build.

Of the following options, only -one- actually exists on alpha,
DEBUG_SLAB:

%if !%build_kdb
        OptionDisable DEBUG_HIGHMEM
        OptionDisable DEBUG_SLAB
        OptionDisable KDB
        OptionDisable KDB_MODULES
        OptionDisable KALLSYMS
%endif


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

