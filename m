Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbUDOQZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbUDOQZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:25:20 -0400
Received: from [62.241.33.80] ([62.241.33.80]:44562 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264334AbUDOQZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:25:14 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Kconfig question || Am I too silly for that simple thing?
Date: Thu, 15 Apr 2004 18:24:55 +0200
User-Agent: KMail/1.6.1
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200404151824.55792@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I want to do the following somewhere in some Kconfig file:

.......

config LOG_SUID
        bool 'Set*id logging'  
        depends on !LOG_SUID_ROOT

config LOG_SUID_ROOT
        bool 'Set*id logging to root'
        depends on !LOG_SUID

.......

And what I get in menuconfig is both config options if they are not selected, 
if I select LOG_SUID, LOG_SUID_ROOT _stays_ visible, if I unselect LOG_SUID, 
LOG_SUID_ROOT _disappears_, if I select LOG_SUID again, LOG_SUID_ROOT 
_appears_ again. If I select LOG_SUID_ROOT the config option LOG_SUID_ROOT 
_disappear_ at all. Heck, am I that silly or is there a bug I don't see or 
so? "=n or "!=y" seems not to work also.

Many thanks.


ciao, Marc
