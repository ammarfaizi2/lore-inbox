Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSGXOpE>; Wed, 24 Jul 2002 10:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSGXOpE>; Wed, 24 Jul 2002 10:45:04 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:62933 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S317363AbSGXOpC>; Wed, 24 Jul 2002 10:45:02 -0400
Date: Wed, 24 Jul 2002 16:48:04 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.28 (linus' bk): conflicting KEY_xxx macros
Message-ID: <20020724144804.GE14143@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/input.h has this:

#define KEY_PLAY	207
#define KEY_FASTFORWARD	    208

#define KEY_PLAY	0x197
#define KEY_FASTFORWARD	    0x19b

which one is where?


  CC     drivers/input/input.o
                 from input.c:31:
In file included from input.c:32:
include/linux/input.h:457: warning: `KEY_PLAY' redefined
include/linux/input.h:310: warning: this is the location of the previous definition
include/linux/input.h:461: warning: `KEY_FASTFORWARD' redefined
include/linux/input.h:311: warning: this is the location of the previous definition

