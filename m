Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVJ0ONt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVJ0ONt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 10:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVJ0ONt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 10:13:49 -0400
Received: from main.gmane.org ([80.91.229.2]:9360 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750806AbVJ0ONs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 10:13:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Neal Becker <ndbecker2@gmail.com>
Subject: can/should inotify support fcntl?
Date: Thu, 27 Oct 2005 10:07:41 -0400
Message-ID: <djqmvc$64g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: nat-expu-253-207.hns.com
User-Agent: KNode/0.9.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to wrap inotify functionality for python.  I ran into a problem. 
In order to use python's select on the fd, I need to use python's
os.fdopen.  It seems os.fdopen calls:

fcntl(4, F_GETFL)                       = -1 EBADF (Bad file descriptor)

Looks like inotify doesn't support calling fcntl.  Should it?

