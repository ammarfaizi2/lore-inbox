Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHFNgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTHFNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:36:41 -0400
Received: from omega-real.bemac.com ([194.193.56.2]:35761 "EHLO
	omega-real.bemac.com") by vger.kernel.org with ESMTP
	id S261180AbTHFNgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:36:40 -0400
Subject: Multiple symbols same address in vmlinux map file? huh?
From: Andy Winton <andreww@bemac.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Aug 2003 14:39:52 +0100
Message-Id: <1060177192.2866.11.camel@pussy.bemac.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

  When doing a 'nm' on the vmlinux I see that some different
  symbols are at the same address.  This seems very strange
  to me.  Can anyone explain this?

  What I typed (to see the duplicates only)...

nm vmlinux-2.4.18-14  | awk 'BEGIN{oldval=01;} { if ($1==oldval) {
if(plast) { print "\n"; print oldrow;} print $0; plast=0} else plast=1;
oldrow=$0; oldval=$1}' - | more

  What I saw....

  [stuff removed...]
c0305a78 d emergency_lock
c0305a78 d emergency_pages

c0303100 d i8259A_irq_type
c0303100 D i8259A_lock

c0386628 B jiffies
c0386628 B jiffies_64
  [stuff removed...]

  Any idea?

  Thanks again,

andy winton

