Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSKUBLy>; Wed, 20 Nov 2002 20:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSKUBLy>; Wed, 20 Nov 2002 20:11:54 -0500
Received: from fmr05.intel.com ([134.134.136.6]:58878 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261701AbSKUBLx>; Wed, 20 Nov 2002 20:11:53 -0500
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758DE4@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Jeff V. Merkey'" <jmerkey@vger.timpanogas.org>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: RE: e1000 fixes (NAPI)
Date: Wed, 20 Nov 2002 17:18:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Need another fix.  You need to reinstrument the tasklet 
> schedule in the fill_rx_ring instread of doing the whole thing from 
> interrupt.  When the system is loaded at 100% saturation on gigbit 
> with 300 byte packets or smaller, the driver does not allow any 
> processes to run, and you cannot log in via ssh or any user space 
> apps.  This is severely busted.   

That's one of the points of NAPI - to process high traffic Rx rates outside
of h/w interrupt context.

-scott
