Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWBVPoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWBVPoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBVPoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:44:24 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:12457 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751342AbWBVPoY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:44:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Git via a proxy server?
Date: Wed, 22 Feb 2006 10:44:23 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F022DD553@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git via a proxy server?
Thread-Index: AcY3xtn7XOPY7JXRTCWzB8RA4H7nMA==
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rsync protocol for git is not working for some reason when I pick up the
trees; apparently others share my experience. So I switched to the git
protocol. I can pick up the trees via git if I am outside Adaptec's
network, but inside I need to go through the proxy server.

Urls like:

git://proxyserver:8080/?url=git://git.kernel.org/pub/scm/linux/kernel/gi
t/jejb/
git://proxyserver:8080/?url=tcp://git.kernel.org/pub/scm/linux/kernel/gi
t/jejb/
git://proxyserver:8080/?url=git.kernel.org/pub/scm/linux/kernel/git/jejb
/

Doesn't even appear to hit the proxy server. MIS had opened up the port
directly as a test using:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/

worked fine, but it can not be a permanent arrangement. They have the
same port on the proxy server set up as well, but the logs indicate zero
hits.

Any ideas?

Sincerely -- Mark Salyzyn
