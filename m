Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270525AbTGUQlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270526AbTGUQkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:40:35 -0400
Received: from smtp.terra.es ([213.4.129.129]:54421 "EHLO tfsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S270525AbTGUQk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:40:26 -0400
From: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
To: linux-kernel@vger.kernel.org
Message-ID: <5f3d05a5f5.5a5f55f3d0@teleline.es>
Date: Mon, 21 Jul 2003 18:55:24 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: Suggestion for a new system call: convert file handle to a
 cookie for transfering file handles between processes.
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My proposal is useful for cases where the server program is running with
a different priviledge from the user invoking it. Examples where this
behaviour is useful are writting CDs, saving man pages, saving TeX cache
files, where full access to a resource would be unsafe, but limited
access through an intermediate server is safe.

In addition, this proposal is useful for cases where the server process
cannot access the named file, becaue it does not have permission to do
so, or because it is anonymous (example: a pipe).

I can't see why cookies introduce circular references. A cookie referes
to an inode, but an inode does not refer to a file.

However, a cookie introduces a permanent reference to a file handle.
This reference is not destroyed until the cookie is used. Therefore,
cookies should have a timeout associated with them, so that if they
are not consumed they should be destroyed.

Ramon




