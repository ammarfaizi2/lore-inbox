Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbSJaQeI>; Thu, 31 Oct 2002 11:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSJaQdF>; Thu, 31 Oct 2002 11:33:05 -0500
Received: from ns.ithnet.com ([217.64.64.10]:37130 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S263232AbSJaQcL>;
	Thu, 31 Oct 2002 11:32:11 -0500
Date: Thu, 31 Oct 2002 17:38:34 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM REPORT 2.4.20-rc1: sundance.c
Message-Id: <20021031173834.4514603a.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'd like to point out that (at least) the network driver sundance.c has weird
flaws when trying to use more than MAX_UNITS (8) cards at the same time. Since
this driver can be used for DFE-580TX 4 port network card it is really easy to
get more than 8 ports :-)
In fact the driver does check against MAX_UNITS, but does _not_ fail if you go
through the roof. Instead you can expect really interesting ifconfig-outputs
;-)
IMHO it should check and fail. I wonder what other card drivers do in such a
case ...
-- 
Regards,
Stephan
