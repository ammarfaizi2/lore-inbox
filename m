Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUIBLmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUIBLmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIBLmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:42:10 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:55953 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S268249AbUIBLmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:42:06 -0400
From: Duncan Sands <baldrick@free.fr>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: external modules make clean doesn't do much
Date: Thu, 2 Sep 2004 13:42:03 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408311347.52754.baldrick@free.fr> <20040831170148.GB7310@mars.ravnborg.org>
In-Reply-To: <20040831170148.GB7310@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021342.03508.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, I found out what was triggering the problem: symbolic links.
The setup was like this:

directory A contains Makefile, source code etc.
B is a symbolic link to A.
If I change directory into A, then "make clean" works fine.
If I change directory into B, then "make clean" only cleans .tmp_versions.

Strange but true...

All the best,

Duncan.
