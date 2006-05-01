Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWEATzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWEATzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWEATx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:53:58 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14477 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932211AbWEATx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:53:56 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 0/7] uts namespaces: Introduction
Message-ID: <20060501203900.XF1836@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: ~/Mail/SENT
Date: Mon,  1 May 2006 14:53:52 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce utsname namespaces.  Instead of a single system_utsname
containing hostname domainname etc, a process can request it's
copy of the uts info to be cloned.  The data will be copied from
it's original, but any further changes will not be seen by processes
which are not it's children, and vice versa.

This is useful, for instance, for vserver/openvz, which can now clone
a new uts namespace for each new virtual server.

Changes since last submission:
	As per Eric's suggestion, switched several uses of init_utsname
		to (per-process namespace) utsname().
	Implemented UTS namespace cloning through clone and unshare.

-serge

