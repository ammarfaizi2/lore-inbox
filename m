Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTEDO2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTEDO2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:28:33 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:3199 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263499AbTEDO2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:28:33 -0400
Date: Sun, 4 May 2003 10:39:23 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: compile fix for IBM PCI hotplug driver (linux 2.4.21rc1-ac4)
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305041040_MC3-1-3755-1BD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>               if(create_file_name (slot_cur, buf)==0)

  Wow.  Three whitespace violations on one line:

        - no space after 'if'
        - space between function and args
        - no space around '==' operator

I know you didn't write that, I just had to comment because it almost
hurts to look at it...

>-                      snprintf (slot_cur->hotplug_slot->name, 30, "%s", );
>+                      snprintf (slot_cur->hotplug_slot->name, 30, "%s" );


  Doesn't this need a fourth parameter here instead of just
removing the comma?


