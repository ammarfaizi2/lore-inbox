Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTLOVim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTLOVim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:38:42 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:12042 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263980AbTLOVik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:38:40 -0500
Date: Mon, 15 Dec 2003 22:39:12 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: request: capabilities that allow users to drop privileges further
Message-ID: <20031215213912.GA29281@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to be able to drop capabilities that every normal user has,
so that network servers can limit the impact of possible future security
problems further.  For example, I want my non-cgi web server to be able
to drop the capabilities to

  * fork
  * execve
  * ptrace
  * load kernel modules
  * mknod
  * write to the file system

and I would like to modify my smtpd to not be able to

  * fork
  * execve
  * ptrace
  * load kernel modules
  * mknod

I can kludge around some of these, for example I can disable fork with
resource limits, and I can limit writing to the file system with chroot
and proper permissions in the file systems, but I'm not aware of a way
to disable ptrace for example, or pthread_create.

I know that there are patches to provide an extended "jail" chroot
support, but being able to drop capabilities like this would be a more
general solution.

Felix
