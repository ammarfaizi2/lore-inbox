Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136240AbREHGlK>; Tue, 8 May 2001 02:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136244AbREHGku>; Tue, 8 May 2001 02:40:50 -0400
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:7582 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S136240AbREHGkp>; Tue, 8 May 2001 02:40:45 -0400
Date: Tue, 8 May 2001 08:40:11 +0200
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: linux-parport@torque.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Small buglet in parport_pc (Linux 2.4.4)
Message-ID: <20010508084011.B4287@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	linux-parport@torque.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

There is a little buglet in v2.4.4.

parport_pc.c will not compile if CONFIG_PCI is not set.  The mistake is
in line 2579:
	static int __init parport_pc_init_superio(void) {return 0;}
This has to be changed to:
	static int __init parport_pc_init_superio(int autoirq, int autodma) {return 0;}
to compile.

Thanks,
  Dominik Kubla
-- 
          A lovely thing to see:                   Kobayashi Issa
     through the paper window's holes               (1763-1828)
                the galaxy.               [taken from: David Brin - Sundiver]
