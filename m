Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760614AbWLFNvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760614AbWLFNvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760606AbWLFNvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:51:09 -0500
Received: from iona.labri.fr ([147.210.8.143]:55356 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760614AbWLFNvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:51:08 -0500
Date: Wed, 6 Dec 2006 14:51:34 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: Linux should define ENOTSUP
Message-ID: <20061206135134.GJ3927@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ENOTSUP is not used at all by linux (though it is defined for parisc),
while as susv3 specifies, ENOTSUP shall be different than EOPNOTSUPP.
Is there a reason for doing so? (except history)

Currently, code like

switch(errno) {
	ENOTSUP:
		foo();
		break;
	EOPNOTSUP:
		bar();
		break;
}
just can't compile...

Is there any way to fix this?  Glibc people don't seem to want to fix it
on their part, see
http://sources.redhat.com/bugzilla/show_bug.cgi?id=2363

Samuel
