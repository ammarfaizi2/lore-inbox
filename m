Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264162AbUDVRwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbUDVRwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbUDVRwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:52:55 -0400
Received: from desnol.ru ([217.150.58.74]:6619 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id S264162AbUDVRwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:52:54 -0400
Date: Thu, 22 Apr 2004 21:53:22 +0400
From: Agri <agri@desnol.ru>
To: linux-kernel@vger.kernel.org
Subject: BUG: fork do not copy /proc/<PID>/cmdline permissions
Message-Id: <20040422215322.19475d98@agri-home>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I expected from fork to make a rather complete copy of a process,
but it does not copy /proc/<PID>/cmdline access permissions.
Therefore, the only way (at least i know) to hide all args of
processes is to start every program within shell script:
bash -c 'chmod /proc/$$/cmdline; exec userprogramm ...'

Tested on 2.6.5.

Agri

