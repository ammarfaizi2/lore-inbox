Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUJ3Tnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUJ3Tnp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbUJ3Tno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:43:44 -0400
Received: from mail.convergence.de ([212.227.36.84]:40941 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261286AbUJ3Tnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:43:42 -0400
Date: Sat, 30 Oct 2004 21:46:47 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: 2.6.10-rc1-bk8: hotplug breakage
Message-ID: <20041030194647.GA5585@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

this patch:

http://linux.bkbits.net:8080/linux-2.6/diffs/lib/kobject_uevent.c@1.10

broke hotplug (the firmware loader in my case),
because the SEQNUM env var will now overwrite an
env var added by hotplug_ops->hotplug() (e.g. FIRMWARE).

Johannes
