Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVCPQwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVCPQwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVCPQwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:52:11 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:18016 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262686AbVCPQwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:52:01 -0500
Message-ID: <4238642F.9080701@tls.msk.ru>
Date: Wed, 16 Mar 2005 19:51:59 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: psmouse et al and mousedev dependancy
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick (hopefully) question.

When mousedev is compiled as a module, loading psmouse or usbhid
modules does not enable the mouse, one have to load mousedev too.
The same is true for keybdev and actual keyboard drivers.

Why not add this dependancy explicitly in psmouse et al modules,
something like (pseudocode):

#if CONFIG_MOUSEDEV==m
  request_module(mousedev);
#endif

, or, to "use" some symbol in psmouse.ko which is defined in mousedev?

Thanks.

/mjt
